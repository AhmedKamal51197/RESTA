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
    Route::get('admin/offers/{id}',[OfferController::class,'show']);

    Route::post('admin/addItems/{id}',[OfferController::class,'addItems']);
    Route::put('admin/offers/{id}',[OfferController::class,'update']);
    Route::get('admin/offers/{id}/items',[OfferController::class,'showItems']);
    Route::delete('admin/offers/{id}',[OfferController::class,'destroy']);
    Route::delete('admin/offers/{id}/items/{itemId}/{type}',[OfferController::class,'deleteItems']);
    Route::get('admin/getAllItems',[OfferController::class,'getAllItems']);

    Route::get('admin/offers/{id}/meals', [OfferController::class, 'showOfferMeals']);
    Route::post('admin/offers/meals', [OfferController::class, 'storeMeal']);
    Route::put('admin/offers/{id}/meals/{meal_id}', [OfferController::class, 'updateOfferMeal']);
    Route::delete('admin/offers/{id}/meals/{meal_id}', [OfferController::class, 'deleteOfferMeal']);

    Route::get('admin/offers/{id}/extras', [OfferController::class, 'showOfferExtras']);
    Route::post('admin/offers/extras', [OfferController::class, 'storeExtra']);
    Route::put('admin/offers/{id}/extras/{meal_id}', [OfferController::class, 'updateOfferExtra']);
    Route::delete('admin/offers/{id}/extras/{extra_id}', [OfferController::class, 'deleteOfferExtra']);


    Route::get('admin/offers/{id}/addons', [OfferController::class, 'showOfferAddons']);
    Route::post('admin/offers/addons', [OfferController::class, 'storeAddon']);
    Route::put('admin/offers/{id}/addons/{addon_id}', [OfferController::class, 'updateOfferAddon']);
    Route::delete('admin/offers/{id}/addons/{addon_id}', [OfferController::class, 'deleteOfferAddon']);


});
// Route::get('/test-update-offers', [OfferController::class, 'updateExpiredOffers']);

Route::get('offers/items/{id}',[OfferController::class,'showOfferItems']);

Route::get('offers/items',[OfferController::class,'items']);

Route::get('offers',[OfferController::class,'indexClient']);
// Route::get('test/{id}/{discount}',[OfferController::class,'getCostAfterDiscount']);


