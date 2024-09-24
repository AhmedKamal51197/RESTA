<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Meal_extra extends Model
{
   protected $fillable = ['meal_id','extra_id'];
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
public function extra()
{
    return $this->belongsTo(Extra::class);
}
public function meal()
{
    return $this->belongsTo(Meal::class);
}
   use HasFactory;
}
