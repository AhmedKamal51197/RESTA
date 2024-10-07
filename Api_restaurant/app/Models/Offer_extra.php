<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;


class Offer_extra extends Model
{
    protected $fillable = ['extra_id','offer_id','extra_quantity'];

    public function extra()
    {
        return $this->belongsTo(Extra::class);
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
