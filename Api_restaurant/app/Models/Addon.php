<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Addon extends Model
{

    protected $fillable=[
        'id',
        'name',
        'cost',
        'description',
        'status',
        'image',
        'category_id',
        'type',
    ];
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
    public function orderaddons()
    {
        return $this->hasMany(OrderAddon::class);
    }
    public function offers()
    {
        return $this->belongsToMany(Offer_addon::class);
    }
    
    public function offer()
    {
        return $this->belongsToMany(Offer::class);
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
   
    public function meals()
    {
        return $this->belongsToMany(Meal::class, 'meal_with_addons');
    }
    public function mealAddons() 
    {
        return $this->hasMany(MealWithAddon::class);
    }
    use HasFactory;
}
