<?php

namespace App\Http\Controllers;

use App\Models\Extra;
use App\Models\Meal;
use App\Models\Meal_extra;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Symfony\Component\EventDispatcher\DependencyInjection\ExtractingEventDispatcher;

use function Laravel\Prompts\error;
use function PHPUnit\Framework\throwException;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class ExtraController extends Controller
{

    // get all extras for admin 
    public function index()
    {
        $perPage=12;
        $extras = Extra::paginate($perPage);
        if ($extras->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No extra exist'
            ], 404);
        }
        $pagination = [
            'total'=>$extras->total(),
            'per_page'=>$extras->perPage(),
            'current_page'=>$extras->currentPage(),
            'last_page'=>$extras->lastPage()
        ];
        return response()->json([
            'status' => 'success',
            'data' => $extras->items(),
            'pagination'=>$pagination
        ], 200);
    }
    // get specific extra by id for admin 
    public function show($id)
    {
        try {
            $extra = Extra::findOrFail($id);
            return response()->json([
                'status' => 'success',
                'data' => $extra
            ], 200);
        } catch (ModelNotFoundException $e) {
            return response()->json([
                'status' => 'failed',
                'message' => 'extra not found'
            ], 404);
        }
    }

    // store extra by admin 
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => ['required','string','regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u','unique:extras'],
            'description' => ['required', 'string', 'min:10','max:255','regex:/^\s*\S(?:.*\S)?\s*$/u'],
            'cost' => ['required', 'numeric','min:1'],
            'status' => ['sometimes', 'boolean'],
            'category_id' => ['required','exists:categories,id'],
            'image' => ['required','image','mimes:jpeg,png,jpg,gif,bmp,svg'],
            'type' => 'sometimes|in:vegetarian,non-vegetarian',
        ]);

        $imagePath = '';
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
            $imagePath = $image->storeAs('extras', $imageName, 'public');
        }

        $extra = Extra::create([
            'name' => $validatedData['name'],
            'description' => $validatedData['description'],
            'cost' => $validatedData['cost'],
            'status' => $validatedData['status'] ?? true,
            'type' => $validatedData['type'] ?? 'vegetarian',
            'category_id' => $validatedData['category_id'],
            'image' => $imagePath,
        ]);
        if (!$extra) {
            return response()->json([
                'status' => 'failed',
                'message' => 'internal server error'
            ], 500);
        }
        return response()->json([
            'status' => 'success',
            'message' => 'added done',
             'data' => $extra,
        ], 200);
    }

    // update extra by admin
    public function update(Request $request, $id)
    {
        $extra = Extra::find($id);
        if (!$extra) {
            return response()->json([
                'status' => 'failed',
                'message' => 'extra not found'
            ], 404);
        }
        $validatedData = $request->validate([
            'name' => ['sometimes','string','regex:/^(?=(?:[\p{L}\s\'&]{0,}[\p{L}]){3,50}$)[\p{L}\s\'&]*$/u',Rule::unique('extras')->ignore($id)],
            'description' => ['sometimes', 'string', 'min:10','max:255','regex:/^\s*\S(?:.*\S)?\s*$/u'],
            'cost' => ['sometimes', 'numeric','min:1'],
            'status' => ['sometimes', 'boolean'],
            'category_id' => ['sometimes','exists:categories,id'],
            'type' => 'sometimes|in:vegetarian,non-vegetarian',
            'image' => ['sometimes','image','mimes:jpeg,png,jpg,gif,bmp,svg']
        ]);

        if ($request->hasFile('image')) {
            if ($extra->image) {
                Storage::disk('public')->delete($extra->image);
            }
            $image = $request->file('image');
            $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
            $imagePath = $image->storeAs('extras', $imageName, 'public');
            $extra->image = $imagePath;
        }

        foreach ($validatedData as $key => $value) {
            if (isset($validatedData[$key])&& $key != 'image') {
                $extra->$key = $value;
            }
        }
        $extra->save();
        return response()->json([
            'status' => 'success',
            'updated data' => $extra
        ], 200);
    }

    //delete extra by admin 
    public function destroy($id)
    {
        try {
            $extra = Extra::findOrFail($id);
            if ($extra) {
                if ($extra->image) {
                    Storage::disk('public')->delete($extra->image);
                }
            }
            $extra->delete();
            return response()->json([
                'status' => 'success',
                'message' => 'extra deleted'
            ], 200);
        } catch (ModelNotFoundException $e) {
            return response()->json([
                'status' => 'failed',
                'message' => 'extra not found'
            ], 404);
        }
    }

    // get extra by meal for website and just display active extra only
    public function getExtraById($meal_id)
    {
        $findMeal = Meal::find($meal_id);
        $extraData = [];
        if (!$findMeal) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No meal Found By this id'
            ], 404);
        } else if ($findMeal->extras->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No extra exist with ' . $findMeal->name
            ], 404);
        }

        foreach ($findMeal->extras as $extra) {
            if($extra->status)
                $extraData[] = ['name' => $extra->name, 'cost' => $extra->cost];
            //$extraData[$key]=$extra->name;
        }
        return response()->json([
            'status' => 'success',
            'data' => $extraData
        ]);
        if (!$findMeal) {
            return response()->json([
                'status' => 'failed',
                'message' => 'no meal with that id found'
            ], 404);
        }
    }


    // store extra that related to specific meal
    public function storeExtraMeals(Request $request ,$meal_id )  {
        $request->validate([
            'extra_ids' => 'required|array',
            'extra_ids.*' => 'integer' // Ensure each ID is an integer
        ]);
        $extra_ids = $request->query('extra_ids');
        $extra_ids=array_map('intval',$extra_ids);
        //dd($request->query('extra_ids'));// to catch array from request->query
        //dd($extra_ids[0]);
        $meal = Meal::find($meal_id);

        if(!$meal) return response()->json([
            'status'=>'failed',
            'message'=>'No meal found with that ID '],404);
        foreach($extra_ids as $extra_id)
        {
            // intval($extra_id);
              //dd(intval($extra_id));
            $extra = Extra::find($extra_id);
            if(!$extra) return response()->json([
                'status'=>'failed',
                'message'=>"No extra found with that ID : $extra_id"
            ],404);

        }
        
        foreach($extra_ids as $extra_id)
        {
            
            $extra = Extra::find($extra_id);

            $meal_extra = Meal_extra::updateOrcreate([
                'meal_id'=>$meal_id,
                'extra_id'=>$extra_id
            ]);
        }

        return response()->json([
            'status'=>'success',
            'message'=>"Added extras for $meal->name successfully"
        ],200);
    } 

    
}
