<?php

use App\Http\Controllers\CustomerController;
use App\Http\Controllers\EmployeeController;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::post('admin/login', [EmployeeController::class, 'login']);

Route::get('admin/test', [EmployeeController::class, 'testMiddleware'])->middleware('auth:admin-api');

// for send reset password email & token to employee
Route::post('admin/employees/forgot-password',[EmployeeController::class,'forogtPassword']);
// this will display in front-end page to  check email & token then send it to  this route =>admin/employees/reset-passowrd to reset password    
Route::get('admin/employees/reset-password-form',[EmployeeController::class,'checkResetToken']);
//  Reset password functional
Route::post('admin/employees/reset-passowrd',[EmployeeController::class,'resetPassword']);


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
    //logout 
});

Route::group(['middleware'=>'auth:admin-api'],function(){
    Route::patch('admin/employees',[EmployeeController::class,'EditHisData']);
    Route::post('admin/logout',[EmployeeController::class,'logout']);
    Route::patch('admin/employees/change-password',[EmployeeController::class,'changePassword']);
    Route::patch('admin/employees/change-email',[EmployeeController::class,'changeEmail']);
    Route::get('admin/refresh',[EmployeeController::class,'refresh']);
});