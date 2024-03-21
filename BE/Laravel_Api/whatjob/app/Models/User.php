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
        'Name',
        'FullName',
        'Email',
        'Password',
        'Born',
        'IsToken',
        'IsBlock',
        'role',
        'token_id'
    ];

    protected $hidden = [
        'role_id',
    ];

    protected $rules = [
        'Name' => 'required',
        'FullName' => 'required',
        'Email' => 'unique:users|required|email',
        'Password' => 'required|min:8',
        'Born' => 'required|numeric',
        'IsBlock' => 'required'
    ];

    public function role(){
        return $this->belongsTo(Role::class);
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
