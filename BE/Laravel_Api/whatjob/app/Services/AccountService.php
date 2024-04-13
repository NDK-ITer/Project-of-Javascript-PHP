<?php

namespace App\Services;

use App\Models\User;
use Exception;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Http\Request;

class AccountService
{

    public function __construct()
    {
    }

    public static function login(array $credentials)
    {
        $user = User::where('email', $credentials['email'])->first();
        if (!$user || ($credentials['password'] != $user->password)) {
            return response()->json([
                'error' => 'Invalid credentials'
            ], 401);
        }
        $token = $user->generateToken();
        $result = UserService::update_expired($user, $token);
        if (!$result) {
            return response()->json([
                'result' => false,
                'message' => 'Cannot create token'
            ], 500);
        }

        return response()->json([
            'token' => $token,
            'user' => $user,
            //'test' => $ds
        ]);
    }
    public static function readable_random_string($length = 6)
    {
        $string = '';
        $vowels = array("a", "e", "i", "o", "u");
        $consonants = array(
            'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm',
            'n', 'p', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z'
        );

        $max = $length / 2;
        for ($i = 1; $i <= $max; $i++) {
            $string .= $consonants[rand(0, 19)];
            $string .= $vowels[rand(0, 4)];
        }

        return $string;
    }
    public static function register(array $input)
    {

        $validator = (new User())->validate($input);

        if ($validator != null) {
            return response()->json($validator);
        }

        $ds = array();
        $ds['email'] = $input['email'];
        $ds['password'] = $input['password'];
        $ds['token_id'] = '';
        $ds['IsBlock'] = 0;
        $user = User::create($ds);
        $user->role_id = $input['roleId'] ?? '97fd62a1-000e-495f-b906-27dcce86f7d4';
        $user->save();
        if (!$user) {
            return response()->json([
                'result' => false,
                'message' => 'Cannot register user'
            ], 500);
        }

        $token = $user->generateToken();
        $result = UserService::update_expired($user, $token);
        if (!$result) {
            return response()->json([
                'result' => false,
                'message' => 'Cannot create token'
            ], 500);
        }

        return response()->json([
            'token' => $token,
            'user' => $user
        ]);
    }




    public static function logout(String $token)
    {
        $decode_token = AccountService::decodeToken($token);
        $user = User::where('Id', $decode_token->id)->first();
        if (!$user) {
            return response()->json([
                'status' => 404,
                'message' => "Data not found",
            ], 404);
        }
        list($headersB64, $payloadB64, $sig) = explode('.', $token);
        $decoded = json_decode(base64_decode($headersB64), true);

        if ($decoded["token_id"] != $user->token_id) {
            return response()->json([
                'status' => 404,
                'message' => "Expired tokens",
            ], 404);
        }

        $result = UserService::delete_token($user, $token);
        if (!$result) {
            return response()->json([
                'result' => false,
                'message' => 'Cannot update token'
            ], 500);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Successfully logged out',
        ], 200);
    }

    public static function getIdToken(String $token)
    {
        try {
            list($headersB64, $payloadB64, $sig) = explode('.', $token);
            $decoded = json_decode(base64_decode($headersB64), true);

            return $decoded["token_id"];
        } catch (Exception $ex) {
            return false;
        }
    }

    public static function decodeToken(String $token)
    {

        try {
            $decoded = JWT::decode($token, new Key(env('JWT_SECRET'), 'HS512'));

            return $decoded;
        } catch (Exception $ex) {
            return $ex->getMessage();
        }
    }

    public static function checkToken(String $token)
    {

        try {
            $decoded = JWT::decode($token, new Key(env('JWT_SECRET'), 'HS512'));

            return $decoded;
        } catch (Exception $ex) {
            return $ex->getMessage();
        }
    }
}
