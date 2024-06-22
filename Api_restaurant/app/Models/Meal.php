<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Meal extends Model
{
    use HasFactory;

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
    protected $fillable = [
        'name', 'size', 'cost', 'description', 'type', 'category_id','image'
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }
    public function extras()
    {
        return $this->belongsToMany(Extra::class,'meal_extras');
    }
    public function ordermeals()
    {
        return $this->hasMany(OrderMeal::class);
    }
}

