<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Offer_meal extends Model
{
   protected $fillable = ['meal_id','offer_id','meal_quantity','meal_size'];

    public function meal()
    {
        return $this->belongsTo(Meal::class);
    }
    public function offer()
    {
        return $this->belongsTo(Offer::class);
    }
    
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
