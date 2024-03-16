<?php

namespace App\Models;

use App\Helpers\Base64Url;
use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
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
        'IsBlock',
        'role'
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
        $header = [
            'alg' => 'HS256',
            'typ' => 'JWT',
        ];

        $payload = [
            'iss' => config('jwt.iss'),
            'aud' => config('jwt.aud'),
            'iat' => time(),
            'nbf' => time() + config('jwt.nbf'),
            'exp' => time() + config('jwt.exp'),
            'sub' => $this->id,
        ];



        $segments = [
            Base64Url::base64url_encode(json_encode($header)),
            Base64Url::base64url_encode(json_encode($payload)),
        ];

        $signing_input = implode('.', $segments);

        $signature = hash_hmac('sha256', $signing_input, config('jwt.secret'), true);

        $segments[] = Base64Url::base64url_encode($signature);

        return implode('.', $segments);
    }


    public function verifyToken($token)
    {
        $segments = explode('.', $token);

        if (count($segments) !== 3) {
            return false;
        }

        $header = json_decode(Base64Url::base64url_decode($segments[0]));
        $payload = json_decode(Base64Url::base64url_decode($segments[1]));
        $signature = Base64Url::base64url_decode($segments[2]);

        $signing_input = implode('.', [$segments[0], $segments[1]]);

        if ($signature !== hash_hmac('sha256', $signing_input, config('jwt.secret'), true)) {
            return false;
        }

        if ($payload->exp < time()) {
            return false;
        }

        return true;
    }
}
