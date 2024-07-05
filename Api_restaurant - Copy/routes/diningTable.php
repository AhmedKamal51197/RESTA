<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DiningTableController;

Route::get('dining-tables/{id}', [DiningTableController::class, 'getDiningTableById']);

Route::group(['middleware'=>'checkAdminToken'],function(){

    Route::get('admin/dining-tables', [DiningTableController::class, 'getAllDiningTables']);
    Route::post('admin/dining-tables', [DiningTableController::class, 'addNewDiningTable']);
    Route::put('admin/dining-tables/{id}', [DiningTableController::class, 'updateDiningTable']);
    Route::delete('admin/dining-tables/{id}', [DiningTableController::class, 'deleteDiningTable']);
    
});