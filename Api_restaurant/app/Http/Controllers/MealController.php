<?php

namespace App\Http\Controllers;

use App\Models\Meal;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class MealController extends Controller
{
    // Fetch all meals
    public function getAllMeals()
    {
        return response()->json(Meal::all());
    }

    // Fetch meal by ID
    public function getMealById($id)
    {
        $meal = Meal::find($id);
        if ($meal) {
            return response()->json($meal);
        }
        return response()->json(['error' => 'Meal not found'], 404);
    }

    // Add a new meal
    public function addMeal(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'size' => 'required|string|max:255',
            'cost' => 'required|numeric',
            'description' => 'required|string',
            'type' => 'required|in:vegetarian,non-vegetarian',
            'category_id' => 'required|exists:categories,id',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048', // Validate the image
        ]);
        
        // Handle the image upload
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
            $imagePath = $image->storeAs('meals', $imageName, 'public');
        }

        $new_meal = Meal::create(array_merge(
            $request->only('name', 'size', 'cost', 'description', 'type', 'category_id'),
            ['image' => $imagePath]
        ));

        return response()->json($new_meal, 201);
    }

    // Update a meal
    public function updateMeal(Request $request, $id)
    {
        $meal = Meal::find($id);
        if ($meal) {
            $request->validate([
                'name' => 'sometimes|required|string|max:255',
                'size' => 'sometimes|required|string|max:255',
                'cost' => 'sometimes|required|numeric',
                'description' => 'sometimes|required|string',
                'type' => 'sometimes|required|in:vegetarian,non-vegetarian',
                'category_id' => 'sometimes|required|exists:categories,id',
                'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048', 
            ]);

            // Handle the image upload
            if ($request->hasFile('image')) {
                // Delete old image if exists
                if ($meal->image) {
                    Storage::disk('public')->delete($meal->image);
                }
                $image = $request->file('image');
                $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
                $imagePath = $image->storeAs('meals', $imageName, 'public');
                $meal->image = $imagePath;
            }

            $meal->update($request->except('image')); 

            return response()->json($meal);
        }
        return response()->json(['error' => 'Meal not found'], 404);
    }

    // Delete a meal
    public function deleteMeal($id)
    {
        $meal = Meal::find($id);
        if ($meal) {
            // Delete the image file if exists
            if ($meal->image) {
                Storage::disk('public')->delete($meal->image);
            }
            $meal->delete();
            return response()->json(['message' => 'Meal deleted successfully']);
        }
        return response()->json(['error' => 'Meal not found'], 404);
    }

    // Filter meals by category
    public function filterByCategory($categoryId)
    {
            //$categoryId=$request->id;
            $meals = Meal::where('category_id',$categoryId )->get();
           // dd($meals);
            
        if($meals->isEmpty())
        {
            return response()->json([
                'status'=>'falied',
                'message'=>'category is empty'
            ],404);
        }
        return response()->json(['status'=>'success',
            'data'=>$meals]);
    }

    // Filter meals by type (vegetarian or non-vegetarian)
    public function filterByType($type)
    {
        if (in_array($type, ['vegetarian', 'non-vegetarian'])) {
            $meals = Meal::where('type', $type)->get();
            return response()->json(['status'=>'success',
            'data'=>$meals]);
        }
        return response()->json(['error' => 'Invalid type'], 400);
    }
}
