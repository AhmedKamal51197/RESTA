<?php

namespace App\Http\Controllers;

use App\Models\Addon;
use App\Models\MealWithAddon;
use App\Models\Meal;
use App\Models\Category;

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
        $isAdmin = Auth::guard('admin-api')->check();
    
        if ($isAdmin) {
            $addons = Addon::with('category')->with('category')->get();
        } else {
            $addons = Addon::where('status', true)->with('category')->get();
        }

        if ($addons->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No addons exist'
            ], 404);
        }
    
        $addons = $addons->map(function ($addon) {
            return [
                'id' => $addon->id,
                'name' => $addon->name,
                'description' => $addon->description,
                'type' => $addon->type,
                'cost' => $addon->cost,
                'category_id' => $addon->category_id ,
                'category_name' => $addon->category ? $addon->category->name : null,
                'status' => $addon->status,
                'image' => $addon->image,
            ];
        });
    
        return response()->json([
            'status' => 'success',
            'data' => $addons,
        ], 200);
    }
    
     // filter addon by ID
     public function filterAddon(Request $request)
     {
         $query = Addon::with('category');
     
         $filters = $request->only(['name', 'cost', 'category_id', 'status', 'type']);
         
         $statusMapping = [
             'inactive' => 0,
             'active' => 1
         ];
         
         foreach ($filters as $key => $value) {
             if (!is_null($value)) {
                 if ($key == 'name') {
                     $query->where($key, 'like', '%' . $value . '%');
                 } elseif ($key == 'status') {
                     $mappedValue = $statusMapping[$value] ?? null;
                     if ($mappedValue !== null) {
                         $query->where($key, $mappedValue);
                     }
                 } else {
                     $query->where($key, $value);
                 }
             }
         }
         
         $addons = $query->get();
         
         if ($addons->isEmpty()) {
             return response()->json([
                 'status' => 'failed',
                 'message' => 'No addons found with the given filters'
             ], 404);
         }
         
     
         $addons = $addons->map(function ($addon) {
            return [
                'id' => $addon->id,
                'name' => $addon->name,
                'cost' => $addon->cost,
                'category_name' => $addon->category ? $addon->category->name : null,
                'status' => $addon->status,
                'image' => $addon->image,
            ];
        });
        
         return response()->json([
             'status' => 'success',
             'data' => $addons,
         ], 200);
     }
     
    
    // Fetch addon by ID 
    public function show($id)
    {
        $addon = Addon::with('category')->find($id);
        
        if ($addon) {
            $addon_Data = [
                'id' => $addon->id,
                'name' => $addon->name,
                'description' => $addon->description,
                'type' => $addon->type,
                'cost' => $addon->cost,
                'category_id' => $addon->category_id,
                'category_name' => $addon->category ? $addon->category->name : null,
                'status' => $addon->status,
                'image' => $addon->image,
            ];
    
            if (Auth::guard('admin-api')->check()) {
                return response()->json(['status' => 'success', 'data' => $addon_Data], 200);
            } else if ($addon->status) {
                return response()->json(['status' => 'success', 'data' => $addon_Data], 200);
            } else {
                return response()->json(['status' => 'failed', 'error' => 'Unauthorized'], 403);
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
            return response()->json(['status' => 'success', 'message' => "The addon has been added successfully"], 201);
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
            return response()->json(['status' => 'success', 'message' => "The addon has been updated successfully"], 200);
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

   // Filter addons by status (active or inactive)
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

        $paginatedAddons = $query->with('category')->paginate($perPage);

        if ($paginatedAddons->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'error' => 'No addons found'
            ], 400);
        }

        $addonsData = $paginatedAddons->map(function ($addon) {
            return [
                'id' => $addon->id,
                'name' => $addon->name,
                'description' => $addon->description,
                'type' => $addon->type,
                'cost' => $addon->cost,
                'category_id' => $addon->category_id,
                'category_name' => $addon->category ? $addon->category->name : null,
                'status' => $addon->status,
                'image' => $addon->image,
            ];
        });

        return response()->json([
            'status' => 'success',
            'data' => $addonsData,
            'pagination' => [
                'total' => $paginatedAddons->total(),
                'per_page' => $paginatedAddons->perPage(),
                'current_page' => $paginatedAddons->currentPage(),
                'last_page' => $paginatedAddons->lastPage(),
            ]
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
        return response()->json(['status' => 'success', 'message' => 'Meal with addon successfully created'], 201);
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

    //  get all addons by meal_id
    public function getAddonsByMeal($meal_id)
    {
        $mealExists = Meal::find($meal_id);
    
        if (!$mealExists) {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }
    
        $addons = MealWithAddon::where('meal_id', $meal_id)->with('addon.category')->get();
    
        if ($addons->isEmpty()) {
            return response()->json(['status' => 'failed', 'error' => 'No addons found for this meal'], 404);
        }
    
        $addonsData = $addons->map(function ($mealWithAddon) {
            return [
                'addon_id' => $mealWithAddon->addon->id,
                'addon_name' => $mealWithAddon->addon->name,
                'status' => $mealWithAddon->addon->status,
            ];
        });
    
        return response()->json(['status' => 'success', 'data' => $addonsData], 200);
    }
    
     // Fetch all addons not related to meal
     public function indexMealAddon(Request $request, $meal_id)
     {
         $isAdmin = Auth::guard('admin-api')->check();
     
         if ($isAdmin) {
             $extras = Addon::whereDoesntHave('mealAddons', function ($query) use ($meal_id) {
                    $query->where('meal_id', $meal_id);
                 })
                 ->get();
         } else {
             $extras = Addon::where('status', true)
                 ->whereDoesntHave('mealAddons', function ($query) use ($meal_id) {
                    $query->where('meal_id', $meal_id);
                 })
                 ->get();
         }
     
         if ($extras->isEmpty()) {
             return response()->json([
                 'status' => 'failed',
                 'message' => 'No extras exist'
             ], 404);
         }
     
         $extras = $extras->map(function ($extra) {
             return [
                 'id' => $extra->id,
                 'name' => $extra->name,
             ];
         });
     
         return response()->json([
             'status' => 'success',
             'data' => $extras,
         ], 200);
     }

}
