<?php

namespace App\Http\Controllers;

use App\Models\Addon;
use App\Models\MealWithAddon;
use App\Models\Meal;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class AddonController extends Controller
{
    // Fetch all addons 
    public function index(Request $request)
    {
        $perPage = 12;
    
        $isAdmin = Auth::guard('admin-api')->check();
    
        if ($isAdmin) {
            $addons = Addon::paginate($perPage);
        } else {
            $addons = Addon::where('status', true)->paginate($perPage);
        }
    
        $pagination = [
            'total' => $addons->total(),
            'per_page' => $addons->perPage(),
            'current_page' => $addons->currentPage(),
            'last_page' => $addons->lastPage(),
        ];

        if ($addons->currentPage() > $addons->lastPage()) {
            return response()->json([
                'status' => 'failed',
                'error' => 'Page number exceeds the last available page'
            ], 400);
        }
    
        if ($addons->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No addon exist'
            ], 404);
        } 

        return response()->json([
            'status' => 'success',
            'data' => $addons->items(), 
            'pagination' => $pagination,
        ], 200);
    }
    
    // Fetch addon by ID 
    public function show($id)
    {
        $addon = Addon::find($id);
    
        if ($addon) {
            if (Auth::guard('admin-api')->check()) {
                return response()->json(['status' => 'success', 'data' => $addon], 200);
            } else if ($addon->status) {
                return response()->json(['status' => 'success', 'data' => $addon], 200);
            } else if(!$addon->status){
                return response()->json(['status' => 'failed', 'error' => 'Unauthorized'], 404);
            }
        }
        return response()->json(['status' => 'failed', 'error' => 'Addon not found'], 404);
    }

    // Add a new addon
    public function store(Request $request)
    {
        $request->validate([
            'name' => ['required','string','regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u','unique:addons'],
            'description' => ['required', 'string', 'min:10','max:255','regex:/^\s*\S(?:.*\S)?\s*$/u'],
            'cost' => 'required|numeric|min:1',
            'category_id' => 'required|exists:categories,id',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,bmp,svg',
            'status' => 'sometimes|boolean',
            'type' => 'sometimes|in:vegetarian,non-vegetarian',
        ]);

        // Handle the image upload
        $imagePath = '';
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
            $imagePath = $image->storeAs('addons', $imageName, 'public');
        }

        $new_addon = Addon::create(array_merge(
            $request->only('name', 'description', 'cost','category_id'),
            ['image' => $imagePath, 'status' => $request->input('status', true) , 'type' => $request->input('type', 'vegetarian')]
        ));

        if ($new_addon) {
            return response()->json(['status' => 'success', 'data' => $new_addon], 201);
        } else {
            return response()->json(['status' => 'failed', 'error' => 'Error during addon addition'], 400);
        }
    }

    // Update an addon
    public function update(Request $request, $id)
    {
        $addon = Addon::find($id);
        if ($addon) {
            $request->validate([
                'name' => ['sometimes','string','regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u',Rule::unique('addons')->ignore($id)],
                'description' => ['sometimes', 'string', 'min:10','max:255','regex:/^\s*\S(?:.*\S)?\s*$/u'],
                'cost' => ['sometimes','numeric','min:1'],
                'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,bmp,svg',
                'status' => 'sometimes|boolean',
                'category_id' => 'sometimes|exists:categories,id',
                'type' => 'sometimes|in:vegetarian,non-vegetarian',
            ]);
    
            // Handle the image upload
            if ($request->hasFile('image')) {
                // Delete old image if exists
                if ($addon->image) {
                    Storage::disk('public')->delete($addon->image);
                }
                $image = $request->file('image');
                $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
                $imagePath = $image->storeAs('addons', $imageName, 'public');
                $addon->image = $imagePath;
            }
    
            $addon->update($request->except('image'));
            return response()->json(['status' => 'success', 'data' => $addon], 200);
        }
        return response()->json(['status' => 'failed', 'error' => 'Addon not found'], 404);
    }
    
    // Delete an addon
    public function destroy($id)
    {
        $addon = Addon::find($id);
        if ($addon) {
            if ($addon->image) {
                Storage::disk('public')->delete($addon->image);
            }
            $addon->delete();
            return response()->json(['status' => 'success', 'message' => 'Addon deleted successfully'], 200);
        }
        return response()->json(['status' => 'failed', 'error' => 'Addon not found'], 404);
    }

    // Filter addons by status (true or false)
    public function filterByStatus($status, Request $request)
    {
        if (!in_array($status, ['inactive', 'active'])) {
            return response()->json([
                'status' => 'failed',
                'error' => 'Invalid status value. Please enter active or inactive'
            ], 400);
        }
    
        $perPage = 12;
    
        $query = $status === 'active' ?
            Addon::where('status', true) :
            Addon::where('status', false);
    
        $addons = $query->get();
    
        if ($addons->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'error' => 'Not found addons'
            ], 400);
        }
    
        $paginatedAddons = $query->paginate($perPage);
    
        $pagination = [
            'total' => $paginatedAddons->total(),
            'per_page' => $paginatedAddons->perPage(),
            'current_page' => $paginatedAddons->currentPage(),
            'last_page' => $paginatedAddons->lastPage(),
        ];
    
        if ($paginatedAddons->currentPage() > $paginatedAddons->lastPage()) {
            return response()->json([
                'status' => 'failed',
                'error' => 'Page number exceeds the last available page'
            ], 400);
        }
    
        return response()->json([
            'status' => 'success',
            'data' => $paginatedAddons->items(),
            'pagination' => $pagination
        ], 200);
    }
    
   
    // add Addon With Meal
    public function storeAddonsWithMeal(Request $request)
    {
        $request->validate([
            'meal_id' => 'required|exists:meals,id',
            'addon_id' => 'required|exists:addons,id',
        ]);

        $existingMealWithAddon = MealWithAddon::where('meal_id', $request->meal_id)
                                              ->where('addon_id', $request->addon_id)->exists();                                              ;

        if ($existingMealWithAddon) {
            return response()->json(['status' => 'failed', 'error' =>'Meal with addon already exists'], 409);
        }

        $mealWithAddon = MealWithAddon::create($request->all());
        $newDataAddon = [
                'meal_name' => $mealWithAddon->meal->name,
                'addon_name' => $mealWithAddon->addon->name,  
        ];

        return response()->json(['status' => 'success', 'data' => $newDataAddon], 201);
    }

    // Delete a meal-with-addon 
    public function destroyAddonsWithMeal($addon_id , $meal_id)
    {
        $deletedRows = MealWithAddon::where('meal_id', $meal_id)->where('addon_id', $addon_id)->delete();
    
        if ($deletedRows) {
            return response()->json(['status' => 'success', 'message' => 'Meal with addon deleted successfully'], 200);
        }
    
        return response()->json(['status' => 'failed', 'error' => 'Meal with addon not found'], 404);
    }

    //  get all addons bu meal_id
    public function getAddonsByMeal($meal_id)
    {
        $mealExists = Meal::find($meal_id);

        if (!$mealExists) {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }

        $addons = MealWithAddon::where('meal_id', $meal_id)->with('addon')->get();

        if ($addons->isEmpty()) {
            return response()->json(['status' => 'failed', 'error' => 'No addons found for this meal'], 404);
        }
        $addonsData = $addons->map(function ($mealWithAddon) {
            return [
                'addon_id' => $mealWithAddon->addon->id,
                'addon_name' => $mealWithAddon->addon->name,
                'category_id' => $mealWithAddon->addon->category_id,                            
            ];
        });

        return response()->json(['status' => 'success', 'data' => $addonsData], 200);
    }

}
