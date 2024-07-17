<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Carbon\Carbon;

class Employee extends Authenticatable implements JWTSubject
{

    protected $fillable= [
        'name',
        'Role',
        'phone',
        'email',
        'password',
        'identity_card',
        'status'
    ];
   
    protected $hidden = [
        'password',
        
    ];
  
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }


    public function getJWTCustomClaims()
    {
        return [
            'id' => $this->id,
        ];
    }

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'Role'=>'integer'
    ];
    public function setRoleAttribute($value)
    {
        $roles = [
            'admin'=>1,
            'chef'=>2,
            'casher'=>3
        ];
        $this->attributes['Role'] = $roles[$value] ?? 3;
    }
    public function getRoleAttribute($value)
    {
        $roles = [
            1=>'admin',
            2=>'chef',
            3=>'casher'
        ];
        return $roles[$value] ??'casher';
    }
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
