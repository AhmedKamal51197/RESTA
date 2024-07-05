<?php

use App\Http\Controllers\OrderController;
use Illuminate\Support\Facades\Route;


Route::get('admin/orders',[OrderController::class,'index']);
Route::get('admin/orders/{id}',[OrderController::class,'show']);

 