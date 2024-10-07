<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Offer extends Model
{
    // use SoftDeletes;
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

    public function getOffer()
    {
        $totalPriceBeforeDiscount = 0;

        $addons = $this->addons->map(function ($offerAddon) use (&$totalPriceBeforeDiscount) {
            $addonPrice = $offerAddon->addon->cost * $offerAddon->addon_quantity;
            $totalPriceBeforeDiscount += $addonPrice;

            return $offerAddon->addon_quantity . ' ' . $offerAddon->addon->name;
        })->join(' + ');

        $mealSizeMap = [
            1 => 'small',
            2 => 'medium',
            3 => 'big',
            4 => 'family',
        ];

        $meals = $this->meals->map(function ($offerMeal) use (&$totalPriceBeforeDiscount, $mealSizeMap) {
            $mealSize = $offerMeal->meal_size; 
            $mealCostRecord = $offerMeal->meal->mealSizeCosts()->where('size', $mealSize)->first(); 
            $mealPrice = ($mealCostRecord ? $mealCostRecord->cost : 0) * $offerMeal->meal_quantity;
            $totalPriceBeforeDiscount += $mealPrice;

            $sizeName = $mealSizeMap[$mealSize] ?? 'unknown'; 

            return $offerMeal->meal_quantity . ' ' . $offerMeal->meal->name . ' (' . $sizeName . ')';
        })->join(' + '); 

    

        $extras = $this->extras->map(function ($offerExtra) use (&$totalPriceBeforeDiscount) {
            $extraPrice = $offerExtra->extra->cost * $offerExtra->extra_quantity;
            $totalPriceBeforeDiscount += $extraPrice;

            return $offerExtra->extra_quantity . ' ' . $offerExtra->extra->name;
        })->join(' + '); 

        $fixedDiscount = $this->discount; 
        $totalPriceAfterDiscount = $totalPriceBeforeDiscount - $fixedDiscount;

        $items = collect([$addons, $meals, $extras])
                    ->filter() 
                    ->join(' + '); 

        return [
            'id' => $this->id,
            'name' => $this->name,
            'discount' => $this->discount,
            'image' => $this->image,
            'status' => $this->status,
            'total_price_before_discount' => $totalPriceBeforeDiscount,
            'total_price_after_discount' => $totalPriceAfterDiscount,
            'items' => $items, 
        ];
    }



    public function showOfferItems($id)
    {
        $totalPriceBeforeDiscount = 0;

        $addons = $this->addons->map(function ($offerAddon) use (&$totalPriceBeforeDiscount) {
            $addonPrice = $offerAddon->addon->cost * $offerAddon->addon_quantity;
            $totalPriceBeforeDiscount += $addonPrice;

            return [
                'id' => $offerAddon->addon_id,
                'quantity' => $offerAddon->addon_quantity,
                'name' => $offerAddon->addon->name,
                'image' => $offerAddon->addon->image,
                'status' => $offerAddon->addon->status,
                'price' => $offerAddon->addon->cost,
            ];
        })->toArray(); 

        $meals = $this->meals->map(function ($offerMeal) use (&$totalPriceBeforeDiscount) {
            $mealSize = $offerMeal->meal_size;
            $mealCostRecord = $offerMeal->meal->mealSizeCosts()->where('size', $mealSize)->first();
            $mealPrice = ($mealCostRecord ? $mealCostRecord->cost : 0) * $offerMeal->meal_quantity;

            $totalPriceBeforeDiscount += $mealPrice;

            return [
                'id' => $offerMeal->meal_id,
                'quantity' => $offerMeal->meal_quantity,
                'size' => $mealSize,
                'name' => $offerMeal->meal->name,
                'image' => $offerMeal->meal->image,
                'status' => $offerMeal->meal->status,
                'price' => $mealCostRecord ? $mealCostRecord->cost : 0,
            ];
        })->toArray(); 

        $extras = $this->extras->map(function ($offerExtra) use (&$totalPriceBeforeDiscount) {
            $extraPrice = $offerExtra->extra->cost * $offerExtra->extra_quantity;
            $totalPriceBeforeDiscount += $extraPrice;

            return [
                'id' => $offerExtra->extra_id,
                'quantity' => $offerExtra->extra_quantity,
                'name' => $offerExtra->extra->name,
                'image' => $offerExtra->extra->image,
                'price' => $offerExtra->extra->cost,
                'status' => $offerExtra->extra->status,

            ];
        })->toArray();

        $items = array_merge($addons, $meals, $extras);

        $fixedDiscount = $this->discount; 
        $totalPriceAfterDiscount = max(0, $totalPriceBeforeDiscount - $fixedDiscount); 

        return [
            'id' => $this->id,
            'name' => $this->name,
            'image' => $this->image,
            'status' => $this->status,
            'start_date' => $this->startDate,
            'end_date' => $this->endDate,
            'total_price_before_discount' => $totalPriceBeforeDiscount,
            'total_price_after_discount' => $totalPriceAfterDiscount,
            'items' => $items,
        ];
    }

    public function getEndDateAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i');
    }
    public function getStartDateAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i');
    }
    
    public function getCreatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }

    public function getUpdatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }

    public function Addons()
    {
        return $this->hasMany(Offer_addon::class); 
    }
    public function Addon()
    {
        return $this->hasMany(Addon::class); 
    }

    public function Extras()
    {
        return $this->hasMany(Offer_extra::class, 'offer_id');
    }
    public function Meals()
    {
        return $this->hasMany(Offer_meal::class, 'offer_id'); 
    }

    public function orderoffers()
    {
        return $this->hasMany(Order_offer::class);
    }
    
}
