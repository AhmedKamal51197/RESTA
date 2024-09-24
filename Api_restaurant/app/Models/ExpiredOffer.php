<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExpiredOffer extends Model
{

    use HasFactory;
    protected $fillable = ['offer_id', 'expired_Date'];

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'expired_Date' => 'datetime:d-m-Y H:i:s',
    ];
    public function getCreatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }

    public function getUpdatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }
    public function offer()
    {
        return $this->belongsTo(Offer::class);
    }
}
