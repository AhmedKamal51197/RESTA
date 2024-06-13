<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use  App\Http\Controllers\CategoriesController;

use App\Http\Controllers\DiningTableController;

Route::get('dining-tables', [DiningTableController::class, 'getAllDiningTables']);
Route::get('dining-tables/{id}', [DiningTableController::class, 'getDiningTableById']);

// Route::group(['middleware'=>'auth:admin-api'],function(){
//      Route::post('dining-tables', [DiningTableController::class, 'addNewDiningTable']);
//      Route::put('dining-tables/{id}', [DiningTableController::class, 'updateDiningTable']);
//      Route::delete('dining-tables/{id}', [DiningTableController::class, 'deleteDiningTable']);
// });
Route::group(['middleware'=>'checkAdminToken'],function(){
     Route::post('dining-tables', [DiningTableController::class, 'addNewDiningTable']);
     Route::put('dining-tables/{id}', [DiningTableController::class, 'updateDiningTable']);
     Route::delete('dining-tables/{id}', [DiningTableController::class, 'deleteDiningTable']);
});