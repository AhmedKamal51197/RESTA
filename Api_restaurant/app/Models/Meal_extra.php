<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Meal_extra extends Model
{
   protected $fillable = ['meal_id','extra_id'];
    use HasFactory;
}
