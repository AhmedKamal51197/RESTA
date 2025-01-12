<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SettingController;

Route::group(['middleware' => 'auth:admin-api'], function () {
    Route::post('/admin/settings', [SettingController::class, 'storeSetting']); 
    Route::get('/admin/settings', [SettingController::class, 'indexSetting']);  
    
    Route::post('/admin/loyalty-settings', [SettingController::class, 'storeLoyaltySetting']);
    Route::get('/admin/loyalty-settings', [SettingController::class, 'indexLoyaltySetting']); 
    Route::put('/admin/settings/logo', [SettingController::class, 'updateLogo']);  
    Route::get('/admin/settings/logo', [SettingController::class, 'showLogo']);   
});

Route::get('/settings', [SettingController::class, 'indexSetting']);  
Route::get('/loyalty-settings', [SettingController::class, 'indexLoyaltySetting']);   





