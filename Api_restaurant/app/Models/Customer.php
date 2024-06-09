<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Contracts\Auth\MustVerifyEmail;



class Customer extends Authenticatable implements JWTSubject,MustVerifyEmail
{

    use Notifiable;
    // protected $guarded=[];
    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'email_verified_at'
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


    public function getJWTCustomClaims()
    {
        return [];
    }

    use HasFactory;
}
