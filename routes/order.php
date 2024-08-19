<?php

use App\Http\Controllers\FatoorahController;
use App\Http\Controllers\OrderController;
use App\Models\OrderAddon;
use Illuminate\Support\Facades\Route;


Route::group(['middleware'=>'auth:api'],function(){
    Route::post('auth/orders',[OrderController::class,'store']);
    Route::post('auth/pay',[OrderController::class,'payOrder']);

});
Route::group(['middleware'=>'checkAdminToken'],function(){
    Route::get('admin/sales',[OrderController::class,'SalesSummary']);
    Route::get('admin/Accepted-Orders',[OrderController::class,'AcceptedOrders']);
    Route::get('admin/items-reports',[OrderController::class,'ItemsReport']);
});
Route::group(['middleware'=>'auth:admin-api'],function(){

    Route::get('admin/orders',[OrderController::class,'index']);
    Route::get('admin/orders/{id}',[OrderController::class,'show']);
    Route::get('admin/orders/{id}/meals',[OrderController::class,'get_order_meals']);
    Route::get('admin/orders/{id}/addons',[OrderController::class,'get_order_addons']);
    Route::get('admin/orders/{id}/extras',[OrderController::class,'get_order_extras']);
    Route::get('admin/customers/{id}/orders',[OrderController::class,'get_user_orders']);
    Route::get('admin/transactions',[OrderController::class,'getAllTransactions']);
    Route::get('admin/transactions/{id}',[OrderController::class,'getTransactionById']);
    Route::put('admin/orders/{id}',[OrderController::class,'changeStatus']);
    // Route::put('admin/orders/{id}/checkPaidStatus',[OrderController::class,'checkPaid']);
    Route::put('admin/orders/{id}/checkPayStatus', [OrderController::class, 'checkPaid']);
    Route::get('admin/table-orders-filter', [OrderController::class, 'filterTableOrde']);

});
Route::get('callback',[OrderController::class,'paymentCallBack']);
Route::get('callbackError',[OrderController::class,'callbackError']);