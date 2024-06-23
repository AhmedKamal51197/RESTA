<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AddonController;



Route::group(['middleware'=>'auth:admin-api'],function(){
    Route::post('/addons', [AddonController::class, 'store']);//// Done test
    Route::put('/addons/{id}', [AddonController::class, 'update']);// Done test
    Route::delete('/addons/{id}', [AddonController::class, 'destroy']);// Done test
    Route::get('/addons/status/{status}', [AddonController::class, 'filterByStatus']);// Done test

    Route::post('/addons-meals', [AddonController::class, 'storeAddonsWithMeal']);//// Done test
    Route::delete('/addons-meals/{addon_id}/{meal_id}', [AddonController::class, 'destroyAddonsWithMeal']);// Done test
    


}); 
Route::get('/addons', [AddonController::class, 'index']);// Done test
Route::get('/addons/{id}', [AddonController::class, 'show']);// Done test


Route::get('/meals/{meal_id}/addons', [AddonController::class, 'getAddonsByMeal']);// Done test


