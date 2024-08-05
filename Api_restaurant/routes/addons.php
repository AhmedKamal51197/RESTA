<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AddonController;



Route::group(['middleware'=>'auth:admin-api'],function(){
    Route::post('/admin/addons', [AddonController::class, 'store']);//// Done test
    Route::put('/admin/addons/{id}', [AddonController::class, 'update']);// Done test
    Route::delete('/admin/addons/{id}', [AddonController::class, 'destroy']);// Done test
    Route::get('/admin/addons/status/{status}', [AddonController::class, 'filterByStatus']);// Done test
    Route::post('/admin/meals/addons', [AddonController::class, 'storeAddonsWithMeal']);//// Done test
    Route::delete('/admin/addons-meals/{addon_id}/{meal_id}', [AddonController::class, 'destroyAddonsWithMeal']);// Done test
    
    Route::get('/admin/addons', [AddonController::class, 'index']);// Done test

    Route::get('/admin/meals/{meal_id}/addons', [AddonController::class, 'getAddonsByMeal']);// Done test
    Route::get('admin/addons-filter', [AddonController::class, 'filterAddon']);// Done test
    Route::get('admin/meals/{meal_id}/options-addons', [AddonController::class, 'indexMealAddon']);
    

}); 

Route::get('/addons/{id}', [AddonController::class, 'show']);// Done test



