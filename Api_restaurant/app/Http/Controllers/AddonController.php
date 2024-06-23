<?php

namespace App\Http\Controllers;

use App\Models\Addon;
use App\Models\MealWithAddon;
use App\Models\Meal;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

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
            'name' => 'required|string|max:255',
            'description' => 'required|string',
            'cost' => 'required|numeric',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif',
            'status' => 'sometimes|in:true,false',
        ]);

        $existingAddon = Addon::where('name', $request->name)->exists();
        if ($existingAddon) {
            return response()->json(['status' => 'failed', 'error' => 'Addon with this name already exists'], 409);
        }

        // Handle the image upload
        $imagePath = '';
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
            $imagePath = $image->storeAs('addons', $imageName, 'public');
        }

        $new_addon = Addon::create(array_merge(
            $request->only('name', 'description', 'cost'),
            ['image' => $imagePath, 'status' => $request->input('status', true)]
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
                'name' => 'sometimes|required|string|max:255',
                'description' => 'sometimes|required|string',
                'cost' => 'sometimes|required|numeric',
                'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048',
                'status' => 'sometimes|in:true,false',
            ]);
    
            // Check if addon with the same name already exists
            $existingAddon = Addon::where('name', $request->name)->where('id', '!=', $id)->first();
            if ($existingAddon) {
                return response()->json(['status' => 'failed', 'error' => 'Addon with this name already exists'], 409);
            }
    
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

        $addons = $status === 'active' ?
            Addon::where('status', true) :
            Addon::where('status', false);

        $addons = $addons->paginate($perPage);

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

        if ($addons->currentPage() > $addons->lastPage()) {
            return response()->json([
                'status' => 'failed',
                'error' => 'Page number exceeds the last available page'
            ], 400);
        }
        
        return response()->json([
            'status' => 'success',
            'data' => $addons->items(),
            "pagination"=>$pagination
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
            ];
        });

        return response()->json(['status' => 'success', 'data' => $addonsData], 200);
    }




}
