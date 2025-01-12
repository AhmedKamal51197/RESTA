<?php

use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\WithdrawController;
use Illuminate\Support\Facades\Route;

Route::post('admin/login', [EmployeeController::class, 'login']);

Route::get('admin/test', [EmployeeController::class, 'testMiddleware'])->middleware('auth:admin-api');

// Send reset password email & token
Route::post('admin/employees/forgot-password', [EmployeeController::class, 'forgotPassword']);

// Display reset password form to check email & token
Route::get('admin/employees/reset-password-form', [EmployeeController::class, 'checkResetToken']);

// Reset password functionality
Route::post('admin/employees/reset-password', [EmployeeController::class, 'resetPassword']);

// Super admin dashboard routes for employees
Route::group(['middleware' => 'checkAdminToken'], function () {
    Route::post('admin/employees', [EmployeeController::class, 'store']);
    Route::get('admin/employees/{id}', [EmployeeController::class, 'show']);
    Route::put('admin/employees/{id}', [EmployeeController::class, 'update']);
    Route::delete('admin/employees/{id}', [EmployeeController::class, 'destroy']);
    Route::get('admin/administrators', [EmployeeController::class, 'indexAdmin']);
    Route::get('admin/employees', [EmployeeController::class, 'indexEmployee']);

    // Withdrawal routes
    Route::post('admin/withdrawals', [WithdrawController::class, 'store']);
    Route::get('admin/withdrawals', [WithdrawController::class, 'index']);
    Route::get('admin/current-balance', [WithdrawController::class, 'getCurrentBalance']);

});

// Admin self-management routes
Route::group(['middleware' => 'auth:admin-api'], function () {
    Route::patch('admin/employees', [EmployeeController::class, 'EditHisData']);
    Route::post('admin/logout', [EmployeeController::class, 'logout']);
    Route::patch('admin/employees/change-password', [EmployeeController::class, 'changePassword']);
    Route::patch('admin/employees/change-email', [EmployeeController::class, 'changeEmail']);
    Route::get('admin/refresh', [EmployeeController::class, 'refresh']);
});

