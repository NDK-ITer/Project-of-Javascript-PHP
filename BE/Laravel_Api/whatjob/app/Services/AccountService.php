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
        $user = User::where('Email', $credentials['Email'])->first();
        if (!$user || ($credentials['Password'] != $user->Password)) {
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

        if($decoded["token_id"] != $user->token_id){
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
        ],200);
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
