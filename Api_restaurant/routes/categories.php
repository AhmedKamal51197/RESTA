<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use  App\Http\Controllers\CategoriesController;


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


Route::get('/products',[CategoriesController::class,'indexProducts'] );
    Route::get('/menu',[CategoriesController::class,'indexMenu'] );

    Route::get('/AllItems',[CategoriesController::class,'AllItems'] );
    Route::get('/categories',[CategoriesController::class,'index'] );
    Route::get('/categories/{id}', [CategoriesController::class, 'getCategoryById']);

    // Authorize for admin only  
    Route::group(['middleware'=>['auth:admin-api','checkAdminToken']],function(){
        Route::post('/categories', [CategoriesController::class,'addNewCategory']);
        Route::put('/categories/{id}', [CategoriesController::class,'updateCategory']);
        Route::delete('/categories/{id}',[CategoriesController::class,'deleteCategory']);    
    });

