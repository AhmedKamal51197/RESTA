<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use App\Models\LoyaltySetting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class SettingController extends Controller
{
    public function indexSetting()
    {
        $settings = Setting::first();
        return response()->json([
            'status' => 'success', 
            'data' => $settings
        ], 200);
    }

    public function indexLoyaltySetting()
    {
        $loyaltySettings = LoyaltySetting::first();
        return response()->json([
            'status' => 'success', 
            'data' => $loyaltySettings
        ], 200);
    }

    

    public function storeSetting(Request $request)
    {
        $request->validate([
            'name' => 'nullable|string|max:255',
            'address' => 'nullable|string|max:255',
            'tax' => 'nullable|numeric',
            'phone1' => 'nullable|string|max:20',
            'phone2' => 'nullable|string|max:20',
            'logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'email' => 'nullable|string|max:100',
            'city' => 'nullable|string|max:50',

        ]);

        $setting = Setting::first();

        $imageName = $setting?->logo;
        if ($request->hasFile('logo')) {
            $image = $request->file('logo');
            $newImageName = 'logos/' . time() . '.' . $image->getClientOriginalExtension();

            if ($imageName && Storage::exists('public/' . $imageName)) {
                Storage::delete('public/' . $imageName);
            }

            $image->storeAs('public', $newImageName);
            $imageName = $newImageName;
        }

        $settingData = array_filter([
            'name' => $request->name,
            'address' => $request->address,
            'tax' => $request->tax,
            'phone1' => $request->phone1,
            'phone2' => $request->phone2,
            'logo' => $imageName,
            'city' => $request->city,
            'email' => $request->email,
        ]);

        if ($setting) {
            $setting->update($settingData);
            $message = 'Settings updated successfully.';
        } else {
            Setting::create($settingData);
            $message = 'Settings created successfully.';
        }

        return response()->json(['status' => 'success', 'message' => $message], 200);
    }

    // دالة لإضافة أو تحديث إعدادات الولاء (LoyaltySetting)
    public function storeLoyaltySetting(Request $request)
    {
        $request->validate([
            'loyalty_points_expiry_days' => 'required|integer',
            'loyalty_min_redeem_points' => 'required|integer',
            'loyalty_max_redeem_points' => 'required|integer',
            'loyalty_max_discount_rate' => 'required|numeric',
            'min_order_price_for_points' => 'required|numeric',
            'price_per_point' => 'required|numeric',
            'currency_per_point' => 'required|numeric',
        ]);

        $loyaltySetting = LoyaltySetting::first();

        $loyaltyData = array_filter([
            'loyalty_points_expiry_days' => $request->loyalty_points_expiry_days,
            'loyalty_min_redeem_points' => $request->loyalty_min_redeem_points,
            'loyalty_max_redeem_points' => $request->loyalty_max_redeem_points,
            'loyalty_max_discount_rate' => $request->loyalty_max_discount_rate,
            'min_order_price_for_points' => $request->min_order_price_for_points,
            'price_per_point' => $request->price_per_point,
            'currency_per_point' => $request->currency_per_point,
        ]);

        if ($loyaltySetting) {
            $loyaltySetting->update($loyaltyData);
            $message = 'Loyalty settings updated successfully.';
        } else {
            LoyaltySetting::create($loyaltyData);
            $message = 'Loyalty settings created successfully.';
        }

        return response()->json(['status' => 'success', 'message' => $message], 200);
    }
}
