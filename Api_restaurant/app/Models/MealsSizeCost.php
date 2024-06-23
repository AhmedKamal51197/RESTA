<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MealsSizeCost extends Model
{
    use HasFactory;

    protected $table = 'meals_size_cost';

    protected $fillable = [
        'meal_id',
        'size',
        'cost',
        'number_of_pieces',
    ];

    public function meal()
    {
        return $this->belongsTo(Meal::class);
    }
}

