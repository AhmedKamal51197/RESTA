<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    //status field => [1 => processing 2=>out of delivery,3=>done]
    protected $fillable = ['customer_id','DiningTable_id','total_cost','status'];
    
    use HasFactory;
}
