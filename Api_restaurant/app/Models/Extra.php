<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Extra extends Model
{
    protected $fillable = ['name', 'cost'];
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
        $this->belongsToMany(Extra::class, 'meal_extras');
    }
    public function orderextras()
    {
        return $this->hasMany(OrderExtra::class);
    }
    use HasFactory;
}
