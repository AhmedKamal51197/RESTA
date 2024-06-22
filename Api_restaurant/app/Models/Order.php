<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Order extends Model
{
    //status field => [1 => processing 2=>out of delivery,3=>done,4=>cancled]
    protected $fillable = ['customer_id','DiningTable_id','total_cost','status','notes','created_at'];

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
    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }
    public function diningtable()
    {
        return $this->belongsTo(DiningTable::class);
    }
    
    public function orderAddons()
    {
        return $this->hasMany(OrderAddon::class);
    }
    
    public function orderMeals()
    {
        return $this->hasMany(OrderMeal::class);
    }
    public function orderExtras()
    {
        return $this->hasMany(OrderExtra::class);
    }
    
    
    use HasFactory;
}
