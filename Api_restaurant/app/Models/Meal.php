<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Meal extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'size', 'cost', 'description', 'type', 'category_id','image'
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}

