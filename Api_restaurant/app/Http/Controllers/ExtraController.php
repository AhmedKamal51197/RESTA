<?php

namespace App\Http\Controllers;

use App\Models\Extra;
use App\Models\Meal;
use App\Models\Meal_extra;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;

class ExtraController extends Controller
{
    // Fetch all extras
    public function index(Request $request)
    {
        $isAdmin = Auth::guard('admin-api')->check();
    
        if ($isAdmin) {
            $extras = Extra::with('category')->get();
        } else {
            $extras = Extra::where('status', true)->with('category')->get();
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
                'description' => $extra->description,
                'cost' => $extra->cost,
                'type' => $extra->type,
                'category_id' => $extra->category_id,
                'category_name' => $extra->category ? $extra->category->name : null,
                'status' => $extra->status,
                'image' => $extra->image,
            ];
        });
    
        return response()->json([
            'status' => 'success',
            'data' => $extras,
        ], 200);
    }

    // filter extra by ID
    public function filterExtra(Request $request)
    {
        $isAdmin = Auth::guard('admin-api')->check();
    
        $query = Extra::with('category');
    
        if (!$isAdmin) {
            $query->where('status', true);
        }
    
        $filters = $request->only(['name', 'cost', 'category_id', 'status', 'type']);
        
        foreach ($filters as $key => $value) {
            if (!is_null($value)) {
                if ($key == 'name') {
                    $query->where($key, 'like', '%' . $value . '%');
                } else {
                    $query->where($key, $value);
                }
            }
        }
        
        $extras = $query->get();
    
        if ($extras->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No extras found with the given filters'
            ], 404);
        }
    
        $extras = $extras->map(function ($extra) {
            return [
                'id' => $extra->id,
                'name' => $extra->name,
                'description' => $extra->description,
                'cost' => $extra->cost,
                'type' => $extra->type,
                'category_id' => $extra->category_id,
                'category_name' => $extra->category ? $extra->category->name : null,
                'status' => $extra->status,
                'image' => $extra->image,
            ];
        });
    
        return response()->json([
            'status' => 'success',
            'data' => $extras,
        ], 200);
    }

    // Fetch extra by ID
    public function show($id)
    {
        $extra = Extra::with('category')->find($id);
        
        if ($extra) {
            $extra_Data = [
                'id' => $extra->id,
                'name' => $extra->name,
                'description' => $extra->description,
                'type' => $extra->type,
                'cost' => $extra->cost,
                'category_id' => $extra->category_id,
                'category_name' => $extra->category ? $extra->category->name : null,
                'status' => $extra->status,
                'image' => $extra->image,
            ];
    
            if (Auth::guard('admin-api')->check()) {
                return response()->json(['status' => 'success', 'data' => $extra_Data], 200);
            } else if ($extra->status) {
                return response()->json(['status' => 'success', 'data' => $extra_Data], 200);
            } else {
                return response()->json(['status' => 'failed', 'error' => 'Unauthorized'], 403);
            }
        }
        return response()->json(['status' => 'failed', 'error' => 'Extra not found'], 404);
    }

    // Add a new extra
    public function store(Request $request)
    {
        $request->validate([
            'name' => ['required','string','regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u','unique:extras'],
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
            $imagePath = $image->storeAs('extras', $imageName, 'public');
        }

        $extra = Extra::create(array_merge(
            $request->only('name', 'description', 'cost', 'category_id'),
            ['image' => $imagePath, 'status' => $request->input('status', true), 'type' => $request->input('type', 'vegetarian')]
        ));

        if ($extra) {
            return response()->json(['status' => 'success', 'message' => "The extra has been added successfully"], 201);
        } else {
            return response()->json(['status' => 'failed', 'error' => 'Error during extra addition'], 400);
        }
    }

    // Update an extra
    public function update(Request $request, $id)
    {
        $extra = Extra::find($id);
        if ($extra) {
            $request->validate([
                'name' => ['sometimes','string','regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u',Rule::unique('extras')->ignore($id)],
                'description' => ['sometimes', 'string', 'min:10','max:255','regex:/^\s*\S(?:.*\S)?\s*$/u'],
                'cost' => ['sometimes','numeric','min:1'],
                'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,bmp,svg',
                'status' => 'sometimes|boolean',
                'category_id' => 'sometimes|exists:categories,id',
                'type' => 'sometimes|in:vegetarian,non-vegetarian',
            ]);
    
            // Handle the image upload
            if ($request->hasFile('image')) {
                if ($extra->image) {
                    Storage::disk('public')->delete($extra->image);
                }
                $image = $request->file('image');
                $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
                $imagePath = $image->storeAs('extras', $imageName, 'public');
                $extra->image = $imagePath;
            }
    
            $extra->update($request->except('image'));
            return response()->json(['status' => 'success', 'message' => "extra has been updated successfully"], 200);
        }
        return response()->json(['status' => 'failed', 'error' => 'Extra not found'], 404);
    }
    
    // Delete an extra
    public function destroy($id)
    {
        $extra = Extra::find($id);
        if ($extra) {
            if ($extra->image) {
                Storage::disk('public')->delete($extra->image);
            }
            $extra->delete();
            return response()->json(['status' => 'success', 'message' => 'Extra deleted successfully'], 200);
        }
        return response()->json(['status' => 'failed', 'error' => 'Extra not found'], 404);
    }

    // Get extras by meal ID
    public function getExtraByMeal($meal_id)
    {
        $meal = Meal::find($meal_id);

        if (!$meal) {
            return response()->json(['status' => 'failed', 'error' => 'Meal not found'], 404);
        }

        $extras = Meal_extra::where('meal_id', $meal_id)->with('extra.category')->get();

        if ($extras->isEmpty()) {
            return response()->json(['status' => 'failed', 'error' => 'No extras found for this meal'], 404);
        }

        $extrasData = $extras->map(function ($mealExtra) {
            return [
                'extra_id' => $mealExtra->extra->id,
                'extra_name' => $mealExtra->extra->name,
                'status' => $mealExtra->extra->status,

            ];
        });

        return response()->json(['status' => 'success', 'data' => $extrasData], 200);
    }

    // add extra With Meal
    public function storeExtraMeals(Request $request)
    {
        $request->validate([
            'meal_id' => 'required|exists:meals,id',
            'extra_id' => 'required|exists:extras,id',
        ]);
    
        $existingMealWithExtra = Meal_extra::where('meal_id', $request->meal_id)
                                           ->where('extra_id', $request->extra_id) 
                                           ->exists();
    
        if ($existingMealWithExtra) {
            return response()->json(['status' => 'failed', 'error' => 'Meal with addon already exists'], 409);
        }
    
        $mealWithExtra = Meal_extra::create($request->all());
    
        return response()->json(['status' => 'success', 'message' => 'Meal with extra successfully created'], 201);
    }

    // Delete a destroy Addons Meal
    public function destroyExtrasMeal($extra_id , $meal_id)
    {
        $deletedRows = Meal_extra::where('meal_id', $meal_id)->where('extra_id', $extra_id)->delete();
    
        if ($deletedRows) {
            return response()->json(['status' => 'success', 'message' => 'Meal with extra deleted successfully'], 200);
        }
    
        return response()->json(['status' => 'failed', 'error' => 'Meal with extra not found'], 404);
    }

     // Fetch all extras not related to meal
     public function indexMealExtra(Request $request, $meal_id)
     {
         $isAdmin = Auth::guard('admin-api')->check();
     
         if ($isAdmin) {
             $extras = Extra::whereDoesntHave('mealExtras', function ($query) use ($meal_id) {
                    $query->where('meal_id', $meal_id);
                 })
                 ->get();
         } else {
             $extras = Extra::where('status', true)
                 ->whereDoesntHave('mealExtras', function ($query) use ($meal_id) {
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
