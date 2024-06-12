<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DiningTable extends Model
{
    use HasFactory;

    protected $fillable = [
        'floor',
        'size',
        'num',
        'status',
        'qr_code',
    ];

    protected $table = 'diningtables';
}
