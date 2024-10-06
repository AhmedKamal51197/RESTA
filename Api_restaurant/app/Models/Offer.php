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

    // public function getOffer()
    // {
    //     return [
    //         'id' => $this->id,
    //         'name' => $this->name,
    //         'discount' => $this->discount,
    //         'image' => $this->image,
    //         'status' => $this->status,
    //         'addons' => $this->addons->map(function ($offerAddon) {
    //             return [
    //                 'addon_id' => $offerAddon->addon_id,
    //                 'addon_quantity' => $offerAddon->addon_quantity,
    //                 'name_addon' => $offerAddon->addon->name, 
    //                 'image_addon' => $offerAddon->addon->image, 
    //             ];
    //         }),
    //         'meals' => $this->meals->map(function ($offerMeal) {
    //             return [
    //                 'meal_id' => $offerMeal->meal_id,
    //                 'meal_quantity' => $offerMeal->meal_quantity,
    //                 'meal_size' => $offerMeal->meal_size,
    //                 'name_meal' => $offerMeal->meal->name, 
    //                 'image_meal' => $offerMeal->meal->image, 
    //             ];
    //         }),
    //         'extras' => $this->extras->map(function ($offerExtra) {
    //             return [
    //                 'extra_id' => $offerExtra->extra_id,
    //                 'extra_quantity' => $offerExtra->extra_quantity,
    //                 'name_extra' => $offerExtra->extra->name, 
    //                 'image_extra' => $offerExtra->extra->image, 
    //             ];
    //         })
    //         // 'meals' => $this->meals,
    //         // 'extras' => $this->extras,
    //     ];
    // }
    
    public function getOffer()
    {
        $totalPriceBeforeDiscount = 0;

        $addons = $this->addons->map(function ($offerAddon) use (&$totalPriceBeforeDiscount) {
            $addonPrice = $offerAddon->addon->cost * $offerAddon->addon_quantity;
            $totalPriceBeforeDiscount += $addonPrice;

            // return [
            //     'addon_id' => $offerAddon->addon_id,
            //     'addon_quantity' => $offerAddon->addon_quantity,
            //     'name_addon' => $offerAddon->addon->name, 
            //     'image_addon' => $offerAddon->addon->image, 
            //     'price_addon' => $offerAddon->addon->cost, 
            // ];
        });

        $meals = $this->meals->map(function ($offerMeal) use (&$totalPriceBeforeDiscount) {
            $mealSize = $offerMeal->meal_size; 
            $mealCostRecord = $offerMeal->meal->mealSizeCosts()->where('size', $mealSize)->first(); 
            $mealPrice = ($mealCostRecord ? $mealCostRecord->cost : 0) * $offerMeal->meal_quantity; 
            $totalPriceBeforeDiscount += $mealPrice;
            // return [
            //     'meal_id' => $offerMeal->meal_id,
            //     'meal_quantity' => $offerMeal->meal_quantity,
            //     'meal_size' => $mealSize,
            //     'name_meal' => $offerMeal->meal->name, 
            //     'image_meal' => $offerMeal->meal->image,
            //     'price_meal' => $mealCostRecord ? $mealCostRecord->cost : 0, 
            // ];
        });
        

        $extras = $this->extras->map(function ($offerExtra) use (&$totalPriceBeforeDiscount) {
            $extraPrice = $offerExtra->extra->cost * $offerExtra->extra_quantity;
            $totalPriceBeforeDiscount += $extraPrice;

            // return [
            //     'extra_id' => $offerExtra->extra_id,
            //     'extra_quantity' => $offerExtra->extra_quantity,
            //     'name_extra' => $offerExtra->extra->name, 
            //     'image_extra' => $offerExtra->extra->image,
            //     'price_extra' => $offerExtra->extra->cost, 
            // ];
        });

        $fixedDiscount = $this->discount; 
        $totalPriceAfterDiscount = $totalPriceBeforeDiscount - $fixedDiscount;
    
        return [
            'id' => $this->id,
            'name' => $this->name,
            'discount' => $this->discount,
            'image' => $this->image,
            'status' => $this->status,
            'total_price_before_discount' => $totalPriceBeforeDiscount, 
            'total_price_after_discount' => $totalPriceAfterDiscount,   
            // 'addons' => $addons,
            // 'meals' => $meals,
            // 'extras' => $extras,
        ];
    }

    // public function showOfferItems($id)
    // {
    //     $totalPriceBeforeDiscount = 0;
    
    //     $addons = $this->addons->map(function ($offerAddon) use (&$totalPriceBeforeDiscount) {
    //         $addonPrice = $offerAddon->addon->cost * $offerAddon->addon_quantity;
    //         $totalPriceBeforeDiscount += $addonPrice;
    
    //         return [
    //             'id' => $offerAddon->addon_id,
    //             'quantity' => $offerAddon->addon_quantity,
    //             'name' => $offerAddon->addon->name,
    //             'image' => $offerAddon->addon->image,
    //             'price' => $offerAddon->addon->cost,
    //         ];
    //     });
    
    //     $meals = $this->meals->map(function ($offerMeal) use (&$totalPriceBeforeDiscount) {
    //         $mealSize = $offerMeal->meal_size;
    //         $mealCostRecord = $offerMeal->meal->mealSizeCosts()->where('size', $mealSize)->first();
    //         $mealPrice = ($mealCostRecord ? $mealCostRecord->cost : 0) * $offerMeal->meal_quantity;
    
    //         $totalPriceBeforeDiscount += $mealPrice;
    
    //         return [
    //             'id' => $offerMeal->meal_id,
    //             'quantity' => $offerMeal->meal_quantity,
    //             'size' => $mealSize,
    //             'name' => $offerMeal->meal->name,
    //             'image' => $offerMeal->meal->image,
    //             'price' => $mealCostRecord ? $mealCostRecord->cost : 0,
    //         ];
    //     });
    
    //     $extras = $this->extras->map(function ($offerExtra) use (&$totalPriceBeforeDiscount) {
    //         $extraPrice = $offerExtra->extra->cost * $offerExtra->extra_quantity;
    //         $totalPriceBeforeDiscount += $extraPrice;
    
    //         return [
    //             'id' => $offerExtra->extra_id,
    //             'quantity' => $offerExtra->extra_quantity,
    //             'extra' => $offerExtra->extra->name,
    //             'extra' => $offerExtra->extra->image,
    //             'extra' => $offerExtra->extra->cost,
    //         ];
    //     });
    
    //     $fixedDiscount = $this->discount; 
    //     $totalPriceAfterDiscount = max(0, $totalPriceBeforeDiscount - $fixedDiscount); 
    
    //     return [
    //         'id' => $this->id,
    //         'name' => $this->name,
    //         'image' => $this->image,
    //         'status' => $this->status,
    //         'total_price_before_discount' => $totalPriceBeforeDiscount,
    //         'total_price_after_discount' => $totalPriceAfterDiscount,
    //         'addons' => $addons,
    //         'meals' => $meals,
    //         'extras' => $extras,
    //     ];
    // }

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

    


    // public function setStartDateAttribute($value)
    // {
    //     $this->attributes['startDate'] = Carbon::createFromFormat('d-m-Y H:i', $value)->format('Y-m-d H:i');
    // }

    // public function setEndDateAttribute($value)
    // {
    //     $this->attributes['endDate'] = Carbon::createFromFormat('d-m-Y H:i', $value)->format('Y-m-d H:i');
    // }
    public function getEndDateAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i');
    }
    public function getStartDateAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i');
    }
    
    // public function setStatusAttribute($value)
    // {
    //     $statuses = [
    //         'inactive' => 0,
    //         'active' => 1
    //     ];
    //     $this->attributes['status'] = $statuses[$value] ?? 1;
    // }
    // public function getStatusAttribute($value)
    // {
    //     $statuses = [
    //         0 => 'inactive',
    //         1 => 'active'
    //     ];
    //     return $statuses[$value] ?? 'active';
    // }
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
