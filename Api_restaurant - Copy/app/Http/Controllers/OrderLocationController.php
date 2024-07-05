<?php

namespace App\Http\Controllers;

use App\Models\OrderLocation;
use Illuminate\Http\Request;

use function PHPSTORM_META\map;

class OrderLocationController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'street'=>['required','string'],
            'area'=>['required','string'],
            'building'=>['required','string']
        ]);
        $location=OrderLocation::create([
            'street'=>$request->street,
            'area'=>$request->area,
            'building'=>$request->building,
            'customer_id'=>auth('api')->id()
        ]);
        return response()->json([
            'status'=>'success',
            'message'=>'Location added done',
            'Location'=>$location
        ],201);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'street'=>['required','string'],
            'area'=>['required','string'],
            'building'=>['required','string']
        ]);
        $location = OrderLocation::find($id);
        if(!$location) return response()->json([
            'status'=>'failed',
            'message'=>'This location doesn\'t fount'
        ],404);
        $location->update([
            'street'=>$request->street,
            'area'=>$request->area,
            'building'=>$request->building
        ]);
        return response()->json([
            'status'=>'success',
            'message'=>'Location updated successfully',
            'Location'=>$location
        ],200);
    }

    public function destroy($id)
    {
        $location = OrderLocation::find($id);
        if(!$location) return response()->json([
            'status'=>'failed',
            'message'=>'Location not found'
        ],404);
        $location->delete();
        return response()->json([
            'status'=>'success',
            'message'=>'Location is deleted successfully'
        ],200);
    }
}
