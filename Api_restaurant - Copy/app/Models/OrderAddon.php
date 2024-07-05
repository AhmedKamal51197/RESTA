<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class OrderAddon extends Model
{
    protected $table='order_addons';
    protected $fillable=[
        'order_id',
        'addon_id',
        'quantity',
        'total_cost'
    ];

    public function order()
    {
        return $this->belongsTo(Order::class);
    }
    public function addon()
    {
        return $this->belongsTo(Addon::class);
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
    use HasFactory;
}
