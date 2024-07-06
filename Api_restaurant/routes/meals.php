<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use  App\Http\Controllers\MealController;
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


Route::group(['middleware' => 'checkAdminToken'], function () {
    Route::post('/admin/meals', [MealController::class, 'store']);
    Route::put('/admin/meals/{id}', [MealController::class, 'update']);
    Route::delete('/admin/meals/{id}', [MealController::class, 'deleteMeal']);
    Route::get('/admin/meals/status/{status}',[MealController::class,'filterByStatus']);
    Route::get('/admin/meals', [MealController::class, 'index']);
    Route::get('/admin/categories/{categoryId}/meals', [MealController::class, 'filterByCategory']);
    Route::get('/admin/meals/type/{type}', [MealController::class, 'filterByType']);


});

Route::get('/meals/{id}', [MealController::class, 'show']);


