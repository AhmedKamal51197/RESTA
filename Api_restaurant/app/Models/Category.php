<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    //New
    protected $fillable =['name', 'description','image'];
    public function meals()
    {
        return $this->hasMany(Meal::class);
    }
}
