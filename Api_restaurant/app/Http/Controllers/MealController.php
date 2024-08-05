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
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;


class MealController extends Controller
{
    // Fetch all meal
    public function index(Request $request)
    {
        $meals = Meal::query();

        if (!Auth::guard('admin-api')->check()) {
            $meals->where('status', true);
        }

        $mealsData = $meals->with('mealSizeCosts', 'addons', 'extras')->get();

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
                        'category_id' => $addon->category_id,
                        'description' => $addon->description,
                        'image' => $addon->image,
                    ];
                }
                return null;
            })->filter()->values();

            $extras = $meal->extras->map(function ($extra) {
                if (Auth::guard('admin-api')->check() || $extra->status) {
                    return [
                        'id' => $extra->id,
                        'name' => $extra->name,
                        'cost' => $extra->cost,
                        'category_id' => $extra->category_id,
                    ];
                }
                return null;
            })->filter()->values();

            $category = Category::where('id', $meal->category_id)->first();
            $minCost = $mealCosts->isEmpty() ? null : $mealCosts->min('cost');

            return [
                'id' => $meal->id,
                'name' => $meal->name,
                'description' => $meal->description,
                'image' => $meal->image,
                'type' => $meal->type,
                'status' => $meal->status,
                'category_name' => $category ? $category->name : null,
                'category_id' => $meal->category_id,
                'price' => $minCost,
                'meal_size_costs' => $mealCosts,
                'addons' => $addons,
                'extras' => $extras,
            ];
        });

        return response()->json(['status' => 'success', 'data' => $DataMeals], 200);
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
            'name' => ['required', 'string', 'regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u', 'unique:meals'],
            'description' => ['required', 'string', 'min:10', 'max:255', 'regex:/^\s*\S(?:.*\S)?\s*$/u'],
            'type' => 'required|in:vegetarian,non-vegetarian',
            'category_id' => 'required|exists:categories,id',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,bmp,svg',
            'status' => 'sometimes|boolean',
            'meal_size_costs' => 'required|array',
            'meal_size_costs.*.number_of_pieces' => ['required_without_all:meal_size_costs.*.size', 'integer', 'min:1'],
            'meal_size_costs.*.size' => ['required_without_all:meal_size_costs.*.number_of_pieces', 'integer', 'min:1', ' max:4'],
            'meal_size_costs.*.cost' => ['required', 'numeric', 'min:1'],
        ]);

        $imagePath = $this->handleImageUpload($request);

        DB::beginTransaction();

        try {

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
                    if (isset($sizeCost['cost'])) {
                        $newMeal->mealSizeCosts()->create([
                            'size' => $sizeCost['size'] ?? null,
                            'cost' => $sizeCost['cost'],
                            'number_of_pieces' => $sizeCost['number_of_pieces'] ?? null,
                        ]);
                    }
                }
            }
            DB::commit();

            // $newMealData = $this->DataMeal($newMeal);

            return response()->json(['status' => 'success', 'message' => "The meal has been added successfully"], 201);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json(['status' => 'error', 'message' => $e->message()], 500);
        }
    }

    // Update a meal
    public function update(Request $request, $id)
    {
        $meal = Meal::find($id);

        if (!$meal) {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }

        $validatedData = $request->validate([
            'name' => ['sometimes', 'string', 'regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u', Rule::unique('meals')->ignore($id)],
            'description' => ['sometimes', 'string', 'min:10', 'max:255', 'regex:/^\s*\S(?:.*\S)?\s*$/u'],
            'type' => 'sometimes|in:vegetarian,non-vegetarian',
            'category_id' => 'sometimes|exists:categories,id',
            'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,bmp,svg',
            'status' => 'sometimes|boolean',
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

        // $meal->refresh();

        // $formattedMeal = $this->DataMeal($meal);

        return response()->json(['status' => 'success', 'message' => "The meal has been updated successfully"], 200);
    }

    //add  size
    public function addMealSizeCost(Request $request, $mealId)
    {
        $meal = Meal::find($mealId);
        if (!$meal) {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }
    
        $validatedData = $request->validate([
            'number_of_pieces' => ['sometimes', 'integer', 'min:1'],
            'size' => ['required', 'integer', 'min:1', 'max:4'],
            'cost' => ['required', 'numeric', 'min:1'],
        ]);
    
        $existingSizeCost = $meal->mealSizeCosts()->where('size', $validatedData['size'])->first();
    
        if ($existingSizeCost) {
            $existingSizeCost->update([
                'number_of_pieces' => $validatedData['number_of_pieces'] ?? $existingSizeCost->number_of_pieces,
                'cost' => $validatedData['cost'],
            ]);
        } else {
            $meal->mealSizeCosts()->create([
                'size' => $validatedData['size'],
                'number_of_pieces' => $validatedData['number_of_pieces'] ?? null,
                'cost' => $validatedData['cost'],
            ]);
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
            return response()->json(['status' => 'failed', 'error' => 'Page number exceeds the last available page'], 400);
        }

        return $DataMeals->isEmpty()
            ? response()->json(['status' => 'failed', 'message' => 'No meals found for this category'], 404)
            : response()->json(['status' => 'success', 'data' => $DataMeals, "pagination" => $pagination], 200);
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
            return response()->json(['status' => 'failed', 'error' => 'Page number exceeds the last available page'], 400);
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
            : response()->json(['status' => 'success', 'data' => $DataMeals, "pagination" => $pagination], 200);
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
            return response()->json(['status' => 'failed', 'error' => 'Page number exceeds the last available page'], 400);
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
            : response()->json(['status' => 'success', 'data' => $DataMeals, "pagination" => $pagination], 200);
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

            $costData['cost'] = $sizeCost->cost;
            return $costData;
        });

        // Fetch addons based on user role and addon status
        $addons = $meal->MealWithAddon->map(function ($mealWithAddon) {
            $addon = $mealWithAddon->addon; // all addons

            if (Auth::guard('admin-api')->check() || $addon->status) {
                return [
                    'id' => $addon->id,
                    'name' => $addon->name,
                    'cost' => $addon->cost,
                    'description' => $addon->description,
                    'category_id' => $addon->category_id,
                    'image' => $addon->image,
                ];
            }

            return null;
        })->filter()->values();

        $extras = $meal->extras->map(function ($extra) {
            if (Auth::guard('admin-api')->check() || $extra->status) {
                return [
                    'id' => $extra->id,
                    'name' => $extra->name,
                    'cost' => $extra->cost,
                    'category_id' => $extra->category_id,
                ];
            }
            return null;
        })->filter()->values();

        $category = Category::where('id', $meal->category_id)->first();

        return [
            'id' => $meal->id,
            'name' => $meal->name,
            'description' => $meal->description,
            'type' => $meal->type,
            'category_name' => $category ? $category->name : null,
            'category_id' => $meal->category_id,
            'image' => $meal->image,
            'status' => $meal->status,
            'meal_size_costs' => $mealCosts->isEmpty() ? null : $mealCosts,
            'addons' => $addons->isEmpty() ? null : $addons,
            'extras' => $extras->isEmpty() ? null : $extras
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

    // filter meals by ID
    public function filterMeal(Request $request)
    {
        $query = Meal::query();

        $filters = $request->only(['name', 'cost', 'size', 'number_of_pieces', 'category_id', 'status', 'type']);
        
        foreach ($filters as $key => $value) {
            if (!is_null($value)) {
                if ($key == 'name') {
                    $query->where($key, 'like', '%' . $value . '%');
                } elseif (in_array($key, ['cost', 'size', 'number_of_pieces'])) {
                    $query->whereHas('mealSizeCosts', function($q) use ($key, $value) {
                        $q->where($key, $value);
                    });
                } else {
                    $query->where($key, $value);
                }
            }
        }
        
        $meals = $query->with(['category', 'mealSizeCosts'])->get();
        
        if ($meals->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No meals found with the given filters'
            ], 404);
        }

        $DataMeals = $meals->map(function ($meal) use ($filters) {
            // جلب التكاليف المطابقة للفلاتر إذا كانت موجودة
            $mealCosts = $meal->mealSizeCosts->filter(function ($sizeCost) use ($filters) {
                foreach (['cost', 'size', 'number_of_pieces'] as $filter) {
                    if (isset($filters[$filter]) && $sizeCost->$filter != $filters[$filter]) {
                        return false;
                    }
                }
                return true;
            });

            $cost = $mealCosts->isNotEmpty() ? $mealCosts->first()->cost : null;

            return [
                'id' => $meal->id,
                'name' => $meal->name,
                'description' => $meal->description,
                'cost' => $cost,
                'type' => $meal->type,
                'category_id' => $meal->category_id,
                'category_name' => optional($meal->category)->name,
                'status' => $meal->status,
                'image' => $meal->image,
            ];
        });

        return response()->json([
            'status' => 'success',
            'data' => $DataMeals,
        ], 200);
    }


}
