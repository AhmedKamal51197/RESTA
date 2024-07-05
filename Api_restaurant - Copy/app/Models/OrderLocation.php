<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
class OrderLocation extends Model
{

    protected $table = 'order_locations';
    protected $fillable =[
        'id',
        'customer_id',
        'street',
        'building',
        'area'
    ] ;
    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }
    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function getCreatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }

    public function getUpdatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }
    use HasFactory;
}
