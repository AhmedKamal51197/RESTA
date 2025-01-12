<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\CustomerLoyaltyPoint;
use App\Models\Customer;
use Carbon\Carbon;

class UpdateLoyaltyPoints extends Command
{
    protected $signature = 'loyalty:updatePoints';

    protected $description = 'Delete expired loyalty points for customers';

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
    }
}
