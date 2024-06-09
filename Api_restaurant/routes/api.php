
<?php

use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Support\Facades\Route;
use  App\Http\Controllers\CustomerController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::group(['middleware' => 'auth:api','verified'], function() {
    // Protected routes// test authentication 
    Route::get('test',[CustomerController::class,'test']);
    Route::post('auth/logout', [CustomerController::class, 'logout']);
    Route::put('auth/customers/{id}',[CustomerController::class,'update']);
});
Route::post('auth/register', [CustomerController::class, 'register']);
Route::post('auth/login', [CustomerController::class, 'login']);
Route::get('auth/verify-user-email',[CustomerController::class,'verifyCustomerEmail']);
Route::post('auth/resend-email-verification-link',[CustomerController::class,'resendVerificationEmailLink']);


