<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use  App\Http\Controllers\MealController;
use App\Http\Controllers\OfferController;

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


Route::group(['middleware'=>'checkAdminToken'],function(){
    Route::post('admin/offers',[OfferController::class,'store']);
    Route::get('admin/offers',[OfferController::class,'index']);
    Route::post('admin/addItems/{id}',[OfferController::class,'addItems']);
    Route::get('admin/offers/{id}',[OfferController::class,'show']);
    Route::put('admin/offers/{id}',[OfferController::class,'update']);
    Route::get('admin/offers/{id}/items',[OfferController::class,'showItems']);
    Route::delete('admin/offers/{id}',[OfferController::class,'destroy']);
    Route::delete('admin/offers/{id}/items/{itemId}/{type}',[OfferController::class,'deleteItems']);
    Route::get('admin/getAllItems',[OfferController::class,'getAllItems']);
    Route::get('admin/offers-filter', [OfferController::class, 'filterOffer']);

});
Route::get('offers',[OfferController::class,'index']);
Route::get('test/{id}/{discount}',[OfferController::class,'getCostAfterDiscount']);


