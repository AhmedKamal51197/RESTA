<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order_offer extends Model
{
    use HasFactory;
    protected $fillable=[
        'order_id',
        'offer_id',
        'quantity',
        'total_cost'
    ];
    protected $table = 'order_offers';

    public function order()
    {
        return $this->belongsTo(Order::class);
    }
    public function offer()
    {
        return $this->belongsTo(Offer::class);
    }
    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
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
