<?php

use App\Http\Controllers\OrderLocationController;
use Illuminate\Support\Facades\Route;
Route::group(['middleware'=>'auth:api'],function(){

    Route::post('auth/order-locations',[OrderLocationController::class,'store']);
    Route::put('auth/order-locations/{id}',[OrderLocationController::class,'update']);
    Route::delete('auth/order-locations/{id}',[OrderLocationController::class,'destroy']);
});