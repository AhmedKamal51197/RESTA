<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Category extends Model
{
    use HasFactory;
    //New
    protected $fillable =['name', 'description','image','status'];
    public function meals()
    {
        return $this->hasMany(Meal::class);
    }
    public function addons()
    {
        return $this->hasMany(Addon::class);
    }
    public function extras()
    {
        return $this->hasMany(Extra::class);
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
