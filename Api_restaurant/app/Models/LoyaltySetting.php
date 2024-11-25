<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use Carbon\Carbon;

class LoyaltySetting extends Model
{
    use HasFactory;

    protected $fillable = [
        'loyalty_points_expiry_days',
        'loyalty_min_redeem_points',
        'loyalty_max_redeem_points',
        'loyalty_max_discount_rate',
        'min_order_price_for_points',
        'price_per_point',
        'currency_per_point',
    ];

    public function getCreatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }

    public function getUpdatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }
}
