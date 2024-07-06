<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Carbon\Carbon;



class Customer extends Authenticatable implements JWTSubject,MustVerifyEmail
{

    use Notifiable;
    // protected $guarded=[];
    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'email_verified_at',
        'status'
    ];
    protected $hidden = [
        'password',
        
    ];
    // if you want to cast timestamp to datetime  
    // protected $casts = [
    //     'email_verified_at' => 'datetime',
    // ];
    public function getJWTIdentifier()
    {
        return $this->getKey();
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


    public function getJWTCustomClaims()
    {
        return [];
    }


    public function orders()
    {
        return $this->hasMany(Order::class);
    }
    public function transactions()
    {
        return $this->hasMany(Transaction::class);
    }
    use HasFactory;
}
