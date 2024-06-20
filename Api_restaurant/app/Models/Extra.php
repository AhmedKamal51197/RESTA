<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Extra extends Model
{
    protected $fillable = ['name', 'cost'];


    public function meals()
    {
        $this->belongsToMany(Extra::class, 'meal_extras');
    }
    use HasFactory;
}
