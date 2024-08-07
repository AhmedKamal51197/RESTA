<?php

use App\Http\Controllers\ExtraController;
use App\Models\Extra;
use Illuminate\Support\Facades\Route;
Route::group(['middleware'=>'checkAdminToken'],function(){

    Route::get('admin/extras', [ExtraController::class, 'index']);
    Route::get('admin/meals/{id}/extras',[ExtraController::class,'getExtraById']);
    Route::post('admin/extras', [ExtraController::class, 'store']);
    Route::put('admin/extras/{id}', [ExtraController::class, 'update']);
    Route::delete('admin/extras/{id}', [ExtraController::class, 'destroy']);
    Route::post('admin/meals/{meal_id}/extras',[ExtraController::class,'storeExtraMeals']);
});

Route::get('extras/{id}', [ExtraController::class, 'show']);

