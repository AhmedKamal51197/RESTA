<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Order;
use App\Models\CustomerLoyaltyPoint;
use App\Models\LoyaltySetting;
use App\Models\Customer;
use Carbon\Carbon;

class UpdateLoyaltyPoints extends Command
{
    protected $signature = 'loyalty:updatePoints';

    protected $description = 'Update loyalty points for accepted and paid orders from the last 24 hours and delete expired points';

    public function handle()
    {
        $expiredPoints = CustomerLoyaltyPoint::where('expiry_date', '<', Carbon::now())->get();

        foreach ($expiredPoints as $point) {
            $point->delete();
            $customer = Customer::find($point->customer_id);
            if ($customer) {
                $customer->decrement('loyalty_points', $point->points);
                $this->info("Expired loyalty points deleted and updated for Customer ID: {$point->customer_id}");
            }
        }

        $twentyFourHoursAgo = Carbon::now()->subDay();
    
        $orders = Order::where('updated_at', '>=', $twentyFourHoursAgo)->get();
    
        foreach ($orders as $order) {
            $loyaltyPoints = CustomerLoyaltyPoint::where('order_id', $order->id)->first();

            if ($order->status === 'Accepted' && $order->pay === 1) {
                $check_add_points = LoyaltySetting::where('min_order_price_for_points', '!=', null)->first();
                if ($check_add_points && $order->total_cost >= $check_add_points->min_order_price_for_points) {
                    $points = floor($order->total_cost / $check_add_points->price_per_point);

                    $expiryDate = Carbon::parse($order->created_at)->addDays($check_add_points->loyalty_points_expiry_days);

                    if ($expiryDate < Carbon::now()) {
                        $this->info("Loyalty points not added for Order ID: {$order->id} as they have expired.");
                        continue; 
                    }

                    CustomerLoyaltyPoint::create([
                        'customer_id' => $order->customer_id,
                        'order_id' => $order->id,
                        'points' => $points,
                        'expiry_date' => $expiryDate,
                    ]);
                    $this->info("Loyalty points added for Order ID: {$order->id}");

                    $customer = Customer::find($order->customer_id);
                    if ($customer) {
                        $customer->increment('loyalty_points', $points);
                        $this->info("Loyalty points updated for Customer ID: {$order->customer_id}");
                    }
                }
            } else {
                if ($loyaltyPoints && ($order->pay == 0 || $order->status != 'Accepted')) {
                    $loyaltyPoints->delete();
                    $this->info("Loyalty points deleted for Order ID: {$order->id}");

                    $customer = Customer::find($order->customer_id);
                    if ($customer) {
                        $customer->decrement('loyalty_points', $loyaltyPoints->points);
                        $this->info("Loyalty points updated for Customer ID: {$order->customer_id}");
                    }
                }
            }
        }
    }
}
