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

Route::group(['middleware' => 'auth:admin-api'], function () {
    Route::post('/meals', [MealController::class, 'addMeal']);
    Route::put('/meals/{id}', [MealController::class, 'updateMeal']);
    Route::delete('/meals/{id}', [MealController::class, 'deleteMeal']);
});

Route::get('/meals', [MealController::class, 'getAllMeals']);
Route::get('/meals/{id}', [MealController::class, 'getMealById']);
Route::get('/categories/{categoryId}/meals', [MealController::class, 'filterByCategory']);
Route::get('/meals/type/{type}', [MealController::class, 'filterByType']);

