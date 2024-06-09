<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use Illuminate\Http\Request;

class EmployeeController extends Controller
{
   
    public function login(LoginRequest $request)
    {
        $token=auth('admin-api')->attempt($request->validated());
        if($token)
        {
            return $this->responseWithToken($token,auth('admin-api')->user());
        }else{
            return response()->json([
                'status'=>'failed',
                'message'=>'Employee not found'
            ],401);
        }
    }
    /***
     * test middleware 
     */
    public function testMiddleware(Request $req)
    {
        return response()->json([
            'status'=>'success',
            'message'=>'he/she is admin'
        ]);
    }
    /**
     * get token response
     */
    public function responseWithToken($token,$user)
    {
        return response()->json([
            'status'=>'success',
            'customer'=>$user,
            'access_token'=>$token,
            'type'=>'bearer'
        ]);
    }
    /**
     * add Employee
    */
    // public function store($)
}
