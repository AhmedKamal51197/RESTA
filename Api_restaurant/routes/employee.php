<?php

use App\Http\Controllers\CustomerController;
use App\Http\Controllers\EmployeeController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::post('admin/login', [EmployeeController::class, 'login']);

Route::get('admin/test', [EmployeeController::class, 'testMiddleware'])->middleware('auth:admin-api');
// employee endpoints in dashboard for super admin
Route::group(['middleware'=>'checkAdminToken'],function(){
    //add  new employee
    Route::post('admin/employees',[EmployeeController::class,'store']);
    //get employee by id 
    Route::get('admin/employees/{id}',[EmployeeController::class,'show']);
    //get all employees 
    Route::get('admin/employees',[EmployeeController::class,'index']);
    //update employee 
    Route::put('admin/employees/{id}',[EmployeeController::class,'update']);
    //delete employee 
    Route::delete('admin/employees/{id}',[EmployeeController::class,'destroy']);
});
