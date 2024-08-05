<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class OrderMeal extends Model
{
    protected $table = 'order_meals';
    protected $fillable = [
        'id',
        'order_id',
        'meal_id',
        'quantity',
        'total_cost'
    ];
    public function order()
    {
        return $this->belongsTo(Order::class);
    }
    public function meal()
    {
        return $this->belongsTo(Meal::class);
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
