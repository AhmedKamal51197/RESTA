<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;


class Offer_addon extends Model
{
    protected $fillable = ['addon_id','offer_id','addon_quantity'];

    public function addon()
    {
        return $this->belongsTo(Addon::class);
    }
    public function Offer()
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
