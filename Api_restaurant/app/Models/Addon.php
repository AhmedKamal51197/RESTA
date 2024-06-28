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
