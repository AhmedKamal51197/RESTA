<?php

use App\Http\Controllers\CustomerController;
use App\Http\Controllers\EmployeeController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::post('admin/login', [EmployeeController::class, 'login']);
Route::group(['middleware'=>'auth:admin-api'],function(){
Route::post('admin/customers',[CustomerController::class,'addCustomer']);
Route::delete('admin/customers/{id}',[CustomerController::class,'destroy']);
Route::put('admin/customers/{id}',[CustomerController::class,'update']);
Route::get('admin/customers/{id}',[CustomerController::class,'show']);
Route::get('admin/customers',[CustomerController::class,'index']);

});
Route::get('admin/test', [EmployeeController::class, 'testMiddleware'])->middleware('auth:admin-api');
