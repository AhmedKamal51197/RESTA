<?php

namespace App\Http\Controllers;

use App\Models\Meal;
use App\Models\Category;
use App\Models\MealsSizeCost;
use App\Models\MealWithAddon;
use App\Models\Addon;
use App\Models\Extra;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class MealController extends Controller
{
    // Fetch all meal
    public function index(Request $request)
    {
        $perPage = 12;
    
        $meals = Meal::query();
    
        if (!Auth::guard('admin-api')->check()) {
            $meals->where('status', true);
        }
    
        $mealsData = $meals->with('mealSizeCosts', 'addons', 'extras')->paginate($perPage);
    
        $DataMeals = $mealsData->map(function ($meal) {
            $mealCosts = $meal->mealSizeCosts->map(function ($sizeCost) {
                $costData = [
                    'id' => $sizeCost->id,
                ];
    
                if (!is_null($sizeCost->number_of_pieces)) {
                    $costData['number_of_pieces'] = $sizeCost->number_of_pieces;
                }
    
                if (!is_null($sizeCost->size)) {
                    $costData['size'] = $sizeCost->size;
                }
    
                $costData['cost'] = $sizeCost->cost;
                return $costData;
            });
    
            $addons = $meal->addons->map(function ($addon) {
                if (Auth::guard('admin-api')->check() || $addon->status) {
                    return [
                        'id' => $addon->id,
                        'name' => $addon->name,
                        'cost' => $addon->cost,
                        'description' => $addon->description,
                        'image' => $addon->image,
                    ];
                }
                return null;
            })->filter();
    
            $extras = $meal->extras->map(function ($extra) {
                if (Auth::guard('admin-api')->check() || $extra->status) {
                    return [
                        'id' => $extra->id,
                        'name' => $extra->name,
                        'cost' => $extra->cost,
                    ];
                }
                return null;
            })->filter()->values();
    
            return [
                'id' => $meal->id,
                'name' => $meal->name,
                'description' => $meal->description,
                'image' => $meal->image,
                'meal_size_costs' => $mealCosts,
                'addons' => $addons,
                'extras' => $extras,
            ];
        });
    
        $pagination = [
            'total' => $mealsData->total(),
            'per_page' => $mealsData->perPage(),
            'current_page' => $mealsData->currentPage(),
            'last_page' => $mealsData->lastPage(),
        ];
    
        
        if ($mealsData->currentPage() > $mealsData->lastPage()) {
            return response()->json(['status' => 'failed','error' => 'Page number exceeds the last available page'], 400);
        }

        return response()->json(['status' => 'success', 'data' => $DataMeals, "pagination" => $pagination], 200);
    }
    

    // Fetch meal by ID
    public function show($id)
    {
        $meal = Meal::with('mealSizeCosts')->find($id);
    
        if (!$meal) {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }
    
        if (!$this->canViewMeal($meal)) {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }
    
        $dataMeal = $this->DataMeal($meal);
        return response()->json(['status' => 'success', 'data' => $dataMeal], 200);
    }
    
    // Add a new meal
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'required|string',
            'type' => 'required|in:vegetarian,non-vegetarian',
            'category_id' => 'required|exists:categories,id',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
            'status' => 'sometimes|boolean',
            'meal_size_costs' => 'required|array',
            'meal_size_costs.*.number_of_pieces' => 'required_without_all:meal_size_costs.*.size|integer',
            'meal_size_costs.*.size' => 'required_without_all:meal_size_costs.*.number_of_pieces|integer',
            'meal_size_costs.*.cost' => 'required|numeric',
        ]);
    
        $imagePath = $this->handleImageUpload($request);
    
        $newMeal = Meal::create([
            'name' => $validatedData['name'],
            'description' => $validatedData['description'],
            'type' => $validatedData['type'],
            'category_id' => $validatedData['category_id'],
            'image' => $imagePath,
            'status' => $validatedData['status'] ?? true,
        ]);
    
        if (isset($validatedData['meal_size_costs'])) {
            foreach ($validatedData['meal_size_costs'] as $sizeCost) {
                if (isset($sizeCost['size']) || isset($sizeCost['number_of_pieces'])) {
                    $newMeal->mealSizeCosts()->create([
                        'size' => $sizeCost['size'] ?? null,
                        'cost' => $sizeCost['cost'],
                        'number_of_pieces' => $sizeCost['number_of_pieces'] ?? null,
                    ]);
                }
            }
        }

        $newMealData = $this->DataMeal($newMeal);
   
        return response()->json(['status' => 'success', 'data' => $newMealData], 201);
    }

    // Update a meal
    public function update(Request $request, $id)
    {
        $meal = Meal::find($id);
        
        if (!$meal) 
        {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }
        
        $validatedData = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'description' => 'sometimes|required|string',
            'type' => 'sometimes|required|in:vegetarian,non-vegetarian',
            'status' => 'sometimes|required|boolean',
            'category_id' => 'sometimes|required|exists:categories,id',
            'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048',
            'meal_size_costs' => 'sometimes|array',
            'meal_size_costs.*.id' => 'sometimes|required|integer|exists:meals_size_costs,id',
            'meal_size_costs.*.size' => 'required_without_all:meal_size_costs.*.number_of_pieces|integer',
            'meal_size_costs.*.number_of_pieces' => 'required_without_all:meal_size_costs.*.size|integer',
            'meal_size_costs.*.cost' => 'required|numeric',
        ]);
        
        if ($request->hasFile('image')) {
            $this->deleteOldImage($meal);
            $validatedData['image'] = $this->handleImageUpload($request);
        }
        
        $meal->update([
            'name' => $validatedData['name'] ?? $meal->name,
            'description' => $validatedData['description'] ?? $meal->description,
            'type' => $validatedData['type'] ?? $meal->type,
            'category_id' => $validatedData['category_id'] ?? $meal->category_id,
            'image' => $validatedData['image'] ?? $meal->image,
            'status' => $validatedData['status'] ?? $meal->status,
        ]);
        
        if (isset($validatedData['meal_size_costs'])) 
        {
            foreach ($validatedData['meal_size_costs'] as $sizeCostData) 
            {
                if (isset($sizeCostData['id'])) 
                {
                    $mealSizeCost = MealsSizeCost::find($sizeCostData['id']);
                    if ($mealSizeCost) {
                        $mealSizeCost->update([
                            'size' => $sizeCostData['size'],
                            'number_of_pieces' => $sizeCostData['number_of_pieces'],
                            'cost' => $sizeCostData['cost'],
                        ]);
                    }
                } 
                else 
                {
                    $meal->mealSizeCosts()->create([
                        'size' => $sizeCostData['size'] ?? null,
                        'number_of_pieces' => $sizeCostData['number_of_pieces'] ?? null,
                        'cost' => $sizeCostData['cost'] ,
                    ]);
                }
            }
        }
        
        $meal->refresh();
        
        $formattedMeal = $this->DataMeal($meal);
        
        return response()->json(['status' => 'success', 'data' => $formattedMeal], 200);
    }

    // Delete a meal
    public function deleteMeal($id)
    {
        $meal = Meal::with('mealSizeCosts')->find($id);        
        if (!$meal) {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }
        $this->deleteOldImage($meal);
        $meal->mealSizeCosts()->delete();
        $meal->delete();
    
        return response()->json(['status' => 'success', 'message' => 'Meal deleted successfully'], 200);
    }

    // Filter meals by category
    public function filterByCategory(Request $request, $categoryId)
    {
        $category = Category::find($categoryId);
        if (!$category) {
            return response()->json(['status' => 'failed', 'error' => 'Category not found'], 404);
        }
    
        $meals = Meal::where('category_id', $categoryId);
    
        if (!Auth::guard('admin-api')->check()) {
            $meals->where('status', true);
        }
    
        $perPage = 12;
    
        $meals = $meals->paginate($perPage);
    
        $DataMeals = $meals->map(function ($meal) {
            return $this->DataMeal($meal);
        });

        $pagination = [
            'total' => $meals->total(),
            'per_page' => $meals->perPage(),
            'current_page' => $meals->currentPage(),
            'last_page' => $meals->lastPage(),
        ];

        if ($meals->currentPage() > $meals->lastPage()) {
            return response()->json(['status' => 'failed','error' => 'Page number exceeds the last available page'], 400);
        }
    
        return $DataMeals->isEmpty()
            ? response()->json(['status' => 'failed', 'message' => 'No meals found for this category'], 404)
            : response()->json(['status' => 'success', 'data' => $DataMeals,"pagination"=>$pagination], 200);
    }
    
    // Filter meals by type (vegetarian or non-vegetarian)
    public function filterByType(Request $request, $type)
    {
    
        if (!in_array($type, ['vegetarian', 'non-vegetarian'])) {
            return response()->json(['status' => 'failed', 'error' => 'Invalid type'], 400);
        }
    
        $perPage = 12;
    
        $mealsQuery = Meal::where('type', $type);
    
        if (!Auth::guard('admin-api')->check()) {
            $mealsQuery->where('status', true);
        }
    

        $meals = $mealsQuery->paginate($perPage);
    
        if ($meals->currentPage() > $meals->lastPage()) {
            return response()->json(['status' => 'failed','error' => 'Page number exceeds the last available page'], 400);
        }
        //  meals data
        $DataMeals = $meals->map(function ($meal) {
            return $this->DataMeal($meal);
        });
    
        $pagination = [
            'total' => $meals->total(),
            'per_page' => $meals->perPage(),
            'current_page' => $meals->currentPage(),
            'last_page' => $meals->lastPage(),
        ];
        return $DataMeals->isEmpty()
            ? response()->json(['status' => 'failed', 'message' => 'No meals found for this type'], 404)
            : response()->json(['status' => 'success', 'data' => $DataMeals,"pagination"=>$pagination], 200);
    }
    
    // Filter meals by status (active or inactive)
    public function filterByStatus(Request $request, $status)
    {
        if (!in_array($status, ['active', 'inactive'])) {
            return response()->json(['status' => 'failed', 'error' => 'Invalid status value. Please enter active or inactive'], 400);
        }
    
        $perPage = 12;
    
        $mealsQuery = Meal::where('status', $status === 'active' ? true : false);
    
        if (!Auth::guard('admin-api')->check()) {
            $mealsQuery->where('status', true);
        }
    
        $meals = $mealsQuery->paginate($perPage);
    
        if ($meals->currentPage() > $meals->lastPage()) {
            return response()->json(['status' => 'failed','error' => 'Page number exceeds the last available page'], 400);
        }
        // Format meals data
        $DataMeals = $meals->map(function ($meal) {
            return $this->DataMeal($meal);
        });
    
        $pagination = [
            'total' => $meals->total(),
            'per_page' => $meals->perPage(),
            'current_page' => $meals->currentPage(),
            'last_page' => $meals->lastPage(),
        ];
        
        return $DataMeals->isEmpty()
            ? response()->json(['status' => 'failed', 'message' => 'No meals found for this status'], 404)
            : response()->json(['status' => 'success', 'data' => $DataMeals,"pagination"=>$pagination], 200);
    }
    
    // function to  meal data
    private function DataMeal($meal)
    {
        // Fetch meal size costs
        $mealCosts = $meal->mealSizeCosts->map(function ($sizeCost) {
            $costData = [
                'id' => $sizeCost->id,
            ];

            if (!is_null($sizeCost->number_of_pieces)) {
                $costData['number_of_pieces'] = $sizeCost->number_of_pieces;
            }

            if (!is_null($sizeCost->size)) {
                $costData['size'] = $sizeCost->size;
            }

            $costData['cost']= $sizeCost->cost;
            return $costData;
        });

        // Fetch addons based on user role and addon status
        $addons = $meal->MealWithAddon->map(function ($mealWithAddon) {
            $addon = $mealWithAddon->addon; // all addons
            
            if (Auth::guard('admin-api')->check() || $addon->status === 'true') { 
                return [
                    'id' => $addon->id,
                    'name' => $addon->name,
                    'cost' => $addon->cost,
                    'description' => $addon->description,
                    'image' => $addon->image,
                ];
            }

            return null;
        })->filter();

        $extras = $meal->extras->map(function ($extra) {
            if (Auth::guard('admin-api')->check() || $extra->status) {
                return [
                    'id' => $extra->id,
                    'name' => $extra->name,
                    'cost' => $extra->cost,
                ];
            }
            return null;
        })->filter()->values();

        return [
            'id' => $meal->id,
            'name' => $meal->name,
            'description' => $meal->description,
            'type' => $meal->type,
            'category_id' => $meal->category_id,
            'image' => $meal->image,
            // 'status' => $meal->status,
            'meal_size_costs' => $mealCosts->isEmpty() ? null : $mealCosts,
            'addons' => $addons->isEmpty() ? null : $addons,
            'extras' =>$extras->isEmpty() ? null : $extras
        ];
    }

    // function to handle image upload
    private function handleImageUpload($request)
    {
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
            $imagePath = $image->storeAs('meals', $imageName, 'public');
            return $imagePath;
        }
    
        return null;
    }
    
    // Helper method to delete old image
    private function deleteOldImage($meal)
    {
        if ($meal->image) {
            Storage::disk('public')->delete($meal->image);
        }
    }
    
    // Helper method to check if meal can be viewed
    private function canViewMeal($meal)
    {
        return Auth::guard('admin-api')->check() || $meal->status;
    }
}
