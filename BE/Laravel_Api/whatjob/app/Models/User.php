<?php

namespace App\Models;

use App\Helpers\Base64Url;
use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Firebase\JWT\JWT;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Ramsey\Uuid\Uuid;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Model
{
    use HasFactory, HasUuids;
    use RelationshipsTrait, ValidatesTrait;

    protected $fillable = [
        //'id',
        'email',
        'password',
        'isToken',
        'isBlock',
        'role',
        'token_id'
    ];

    protected $hidden = [
        'role_id',
    ];

    protected $rules = [
        // 'fullName' => 'required',
        'email' => 'unique:users|required|email',
        'password' => 'required|min:8',
        // 'Born' => 'date_format:Y-m-d',
        // 'IsBlock' => 'required'
    ];

    public function role(){
        return $this->belongsTo(Role::class);
    }

    public function employer(){
        return $this->hasOne(Employer::class, 'id', 'id');
    }

    public function employee(){
        return $this->hasOne(Employee::class, 'id', 'id');
    }

    public function generateToken()
    {
        $headers = [
            'token_id' => Uuid::uuid4()->toString(),
        ];
        $payload = [
            'id' => $this->id,
            'email' => $this->Email,
            'exp' => time() + env('JWT_TIME_EXP') // Token expiration time (in seconds)
        ];
        $token = JWT::encode($payload, env('JWT_SECRET'), 'HS512', null, $headers);
        return $token;
    }
}
