<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Offer extends Model
{
    use SoftDeletes;
    use HasFactory;
    protected $fillable = [
        'name',
        'status',
        'image',
        'meal_id',
        'addon_id',
        'extra_id',
        'startDate',
        'endDate',
        'type',
        'quantity',
        'discount'
    ];
    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'startDate' => 'datetime',
        'endDate' => 'datetime',
    ];
    public function setStartDateAttribute($value)
    {
        $this->attributes['startDate'] = Carbon::createFromFormat('d-m-Y H:i:s', $value)->format('Y-m-d H:i:s');
    }

    public function setEndDateAttribute($value)
    {
        $this->attributes['endDate'] = Carbon::createFromFormat('d-m-Y H:i:s', $value)->format('Y-m-d H:i:s');
    }
    public function getEndDateAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }
    public function getStartDateAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }
    
    public function setStatusAttribute($value)
    {
        $statuses = [
            'inactive' => 0,
            'active' => 1
        ];
        $this->attributes['status'] = $statuses[$value] ?? 1;
    }
    public function getStatusAttribute($value)
    {
        $statuses = [
            0 => 'inactive',
            1 => 'active'
        ];
        return $statuses[$value] ?? 'active';
    }
    public function getCreatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }

    public function getUpdatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }
    public function extras()
    {
        return $this->belongsToMany(Extra::class, 'offer_items')
            ->withPivot('extra_quantity');
    }
    public function meals()
    {
        return $this->belongsToMany(Meal::class, 'offer_items')
            ->withPivot('meal_quantity');
    }
    public function addons()
    {
        return $this->belongsToMany(Addon::class, 'offer_items')
            ->withPivot('addon_quantity');
    }
    public function orderoffers()
    {
        return $this->hasMany(Order_offer::class);
    }
    
}
