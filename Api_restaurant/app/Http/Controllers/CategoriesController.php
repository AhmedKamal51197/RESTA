<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Traits\GeneralTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator; 

class CategoriesController extends Controller
{
    
    public function getAllCategories()
    {
        $categories = Category::all();
        if ($categories->isEmpty()) {
            return response()->json(['message' => 'No categories found'], 404);//status
        }
        
        return response()->json(['data' => $categories, 'status' => 200], 200);
    }

    public function getCategoryById($id)
    {
        $category = Category::find($id);
        if (!$category) {
            return response()->json(['message' => 'Category not found'], 404);
        }
        return response()->json(['data' => $category, 'status' => 200], 200);
    }

    public function addNewCategory(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
            'description' => 'required|string',
            'image_file' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048', // For image file
        ]);
    
        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()], 400);
        }
    
        if (Category::where('name', $request->name)->exists()) {
            return response()->json(['message' => 'Category already exists'], 409);
        }
    
        $data = $request->only('name', 'description');
    
        // Handle image file from form data
        if ($request->hasFile('image_file')) {
            $data['image'] = $request->file('image_file')->store('categories', 'public');
        }
    
        $newCategory = Category::create($data);
        return response()->json(['data' => $newCategory, 'status' => 201], 201);
    }
    

    public function updateCategory(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'nullable|string',
            'description' => 'nullable|string',
            'image_file' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048', 
        ]);
    
        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(), 'status' => 400], 400);
        }
    
        $category = Category::find($id);
        if (!$category) {
            return response()->json(['message' => 'Category not found', 'status' => 404], 404);
        }
    
        $data = $request->only('name', 'description');
    
     
        if ($request->hasFile('image_file')) {
        
            if ($category->image) {
                Storage::disk('public')->delete($category->image);
            }
            
            
            $data['image'] = $request->file('image_file')->store('categories', 'public');
        }
    
        $category->update($data);
        
        
        $updatedCategory = Category::find($id);
        return response()->json(['data' => $updatedCategory, 'status' => 200], 200);
    }
    
    
    public function deleteCategory($id)
    {
        $category = Category::find($id);
        if (!$category) {
            return response()->json(['message' => 'Category not found', 'status' => 404], 404);
        }

        if ($category->image) {
            Storage::disk('public')->delete($category->image);
        }

        $category->delete();
        return response()->json(['message' => 'Category deleted successfully', 'status' => 200], 200);
    }
}
