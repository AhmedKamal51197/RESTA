<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Order extends Model
{
    //status field => [1 => processing 2=>out of delivery,3=>done,4=>cancled]
    protected $fillable = ['customer_id','location_id','DiningTable_id','total_cost','status','notes','created_at','pay','PaymentType'];

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'status'=>'integer'
    ];
    public function setStatusAttribute($value)
    {
        $statuses = [
            'Not Started'=>1,
            'In Progress'=>2,
            'Cancelled'=>3,
            'Accepted'=>4
        ];
        $this->attributes['status']=$statuses[$value] ?? 1;
    }
    public function getStatusAttribute($value){
        $statuses = [
            1=>'Not Started',
            2=>'In Progress',
            3=>'Cancelled',
            4=>'Accepted'
        ];
        return $statuses[$value]??'Not Started';
    }
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
    
    public function orderLocation()
    {
        return $this->belongsTo(OrderLocation::class);
    }
    public function transaction()
    {
        return $this->hasOne(Transaction::class);
    }
    public function orderOffers()
    {
        return $this->hasMany(Order_offer::class);
    }
    
    use HasFactory;
}
