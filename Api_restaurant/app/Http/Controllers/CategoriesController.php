<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Traits\GeneralTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator; 
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

use App\Models\Meal;
use App\Models\Addon;
use App\Models\Extra;

class CategoriesController extends Controller
{
    
    public function AllItems(Request $request)
    {
        $perPage = 12;
        
        $meals = [];
        $addons = [];
        $extras = [];

        $mealsQuery = Meal::where('status', 1);
        if ($request->has('category_id')) {
            $mealsQuery->where('category_id', $request->category_id);
        }
        $meals = $mealsQuery->get()->map(function ($meal) {
            $mealData = $this->DataMeal($meal);
            $mealData['table_name'] = 'meals';
            return $mealData;
        })->toArray();

        $addonsQuery = Addon::where('status', 1);
        if ($request->has('category_id')) {
            $addonsQuery->where('category_id', $request->category_id);
        }
        $addons = $addonsQuery->get()->map(function ($addon) {
            $addon['table_name'] = 'addons'; 
            return $addon;
        })->toArray();

        $extrasQuery = Extra::where('status', 1);
        if ($request->has('category_id')) {
            $extrasQuery->where('category_id', $request->category_id);
        }
        $extras = $extrasQuery->get()->map(function ($extra) {
            $extra['table_name'] = 'extras'; 
            return $extra;
        })->toArray();

        $allItems = array_merge($meals, $addons, $extras);

        $totalItems = count($allItems);
        $currentPage = $request->query('page', 1);
        $offset = ($currentPage - 1) * $perPage;
        $itemsForPage = array_slice($allItems, $offset, $perPage);
        $lastPage = ceil($totalItems / $perPage);

        $pagination = [
            'total' => $totalItems,
            'per_page' => $perPage,
            'current_page' => $currentPage,
            'last_page' => $lastPage,
        ];

        return response()->json([
            'status' => 'success',
            'data' => $itemsForPage,
            'pagination' => $pagination,
        ], 200);
    }

    public function indexProducts(Request $request)
    {
        $mealsQuery = Meal::where('status', 1);
        if ($request->has('category_id')) {
            $mealsQuery->where('category_id', $request->category_id);
        }
        $meals = $mealsQuery->get()->map(function ($meal) {
            return $this->DataMeal($meal);
        })->toArray();
    
        $addonsQuery = Addon::where('status', 1);
        if ($request->has('category_id')) {
            $addonsQuery->where('category_id', $request->category_id);
        }
        $addons = $addonsQuery->get()->map(function ($addon) {
            return $addon;
        })->toArray();
    
        $extrasQuery = Extra::where('status', 1);
        if ($request->has('category_id')) {
            $extrasQuery->where('category_id', $request->category_id);
        }
        $extras = $extrasQuery->get()->map(function ($extra) {
            $extra['table_name'] = 'extras';
            return $extra;
        })->toArray();
    
        return response()->json([
            'status' => 'success',
            'meals' => $meals,
            'addons' => $addons,
            'extras' => $extras,
        ], 200);
    }

    // fetch menu
    public function indexMenu(Request $request)
    {
        $mealsQuery = Meal::where('status', 1);
        if ($request->has('category_id')) {
            $mealsQuery->where('category_id', $request->category_id);
        }
        $meals = $mealsQuery->get()->map(function ($meal) {
            return $this->DataMeal($meal);
        })->toArray();
    
        $addonsQuery = Addon::where('status', 1);
        if ($request->has('category_id')) {
            $addonsQuery->where('category_id', $request->category_id);
        }
        $addons = $addonsQuery->get()->map(function ($addon) {
            $addonArray = $addon->toArray();
            unset($addonArray['created_at'], $addonArray['updated_at']); 
            return $addonArray;
        })->toArray();
    
        $extrasQuery = Extra::where('status', 1);
        if ($request->has('category_id')) {
            $extrasQuery->where('category_id', $request->category_id);
        }
        $extras = $extrasQuery->get()->map(function ($extra) {
            $extraArray = $extra->toArray();
            unset($extraArray['created_at'], $extraArray['updated_at']); 
            return $extraArray;
        })->toArray();
    
        return response()->json([
            'status' => 'success',
            'data' => [
                'meals' => $meals,
                'addons' => $addons,
                'extras' => $extras,
            ],
        ], 200);
    }
    

    public function index(Request $request){
        $categories = Category::all();
        
        if ($categories->isEmpty()) {
            return response()->json(['status'=>'failed','message' => 'No categories found'], 404);
        }

        return response()->json(['status'=>'success','data' => $categories], 200);

    }

    public function getCategoryById($id)
    {
        $category = Category::with('meals','addons','extras')->find($id);
        if (!$category) {
            return response()->json(['message' => 'Category not found','status'=>'failed'], 404);
        }
        return response()->json(['data' => $category, 'status' => 'success'], 200);
    }

    public function addNewCategory(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required','string','regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u','unique:categories'],
            'description' => ['required', 'string', 'min:10','max:255','regex:/^\s*\S(?:.*\S)?\s*$/u'],
            'image_file' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg', 
            'status' => 'required|boolean', // Add validation for status
        ]);
    
        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(),'status'=>'failed'], 400);
        }
    
        $data = $request->only('name', 'description' ,'status');
    
        // Handle image file from form data
        if ($request->hasFile('image_file')) {
            $data['image'] = $request->file('image_file')->store('categories', 'public');
        }
    
        $newCategory = Category::create($data);
        // $responseData = array_merge($newCategory->toArray(), ['status' => $newCategory->status]);

        return response()->json(['message' => "The addon has been added successfully", 'status' => 'success'], 201);
    }
    
    public function updateCategory(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['sometimes','string','regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u',Rule::unique('categories')->ignore($id)],
            'description' => ['sometimes', 'string', 'min:10','max:255','regex:/^\s*\S(?:.*\S)?\s*$/u'],
            'image_file' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg', 
        ]);
    
        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(), 'status' => 'failed'], 400);
        }
    
        $category = Category::find($id);
        if (!$category) {
            return response()->json(['message' => 'Category not found', 'status' =>  'failed'], 404);
        }
    
        $data = $request->only('name', 'description','status');
    
     
        if ($request->hasFile('image_file')) {
        
            if ($category->image) {
                Storage::disk('public')->delete($category->image);
            }
            
            
            $data['image'] = $request->file('image_file')->store('categories', 'public');
        }
    
        $category->update($data);
        
        
        return response()->json(['message' => "The category has been updated successfully", 'status' => 'success'], 200);
    }
    
    
    public function deleteCategory($id)
    {
        $category = Category::find($id);
        if (!$category) {
            return response()->json(['message' => 'Category not found', 'status' => 'failed'], 404);
        }

        if ($category->image) {
            Storage::disk('public')->delete($category->image);
        }

        $category->delete();
        return response()->json(['message' => 'Category deleted successfully', 'status' => 'success'], 200);
    }

    // meals get data
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

        return [
            'id' => $meal->id,
            'name' => $meal->name,
            'description' => $meal->description,
            'type' => $meal->type,
            'category_id' => $meal->category_id,
            'image' => $meal->image,
            'status' => $meal->status,
            'meal_size_costs' => $mealCosts->isEmpty() ? null : $mealCosts,
            'addons' => $addons->isEmpty() ? null : $addons,
            'extras' =>$extras->isEmpty() ? null : $extras
        ];
    }
}
