<?php

use App\Http\Controllers\ExtraController;
use App\Models\Extra;
use Illuminate\Support\Facades\Route;
Route::group(['middleware'=>'auth:admin-api'],function(){

    Route::get('admin/extras', [ExtraController::class, 'index']);
    Route::get('admin/extras/{id}', [ExtraController::class, 'show']);
    Route::post('admin/extras', [ExtraController::class, 'store']);
    Route::put('admin/extras/{id}', [ExtraController::class, 'update']);
    Route::delete('admin/extras/{id}', [ExtraController::class, 'destroy']);
});

Route::post('meals/{id}/extras',[ExtraController::class,'getExtraById']);
