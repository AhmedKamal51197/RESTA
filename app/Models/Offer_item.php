<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Offer_item extends Model
{
   use SoftDeletes;
   use HasFactory;
    protected $table = 'offer_items';
    protected $fillable = [
        'offer_id',
        'meal_id',
        'meal_quantity',
        'extra_id',
        'extra_quantity',
        'addon_id',
        'addon_quantity'
    ];
    public function addon()
    {
        return $this->belongsTo(Addon::class);
    }
    public function extra()
    {
        return $this->belongsTo(Extra::class);
    }
    public function meal()
    {
        return $this->belongsTo(Meal::class);
    }
    public function offer()
    {
        return $this->belongsTo(Offer::class);
    }
  
}
