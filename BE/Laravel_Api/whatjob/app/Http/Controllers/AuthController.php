<?php

namespace App\Http\Controllers;

use App\Helpers\Base64Url;
use App\Models\User;
use App\Services\AccountService;
use App\Services\AuthService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use RuntimeException;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $result = AccountService::register($request->all());
        return $result;
    }


    public function login(Request $request)
    {


        $result = AccountService::login($request->all());

        return $result;
    }



    public function checkToken(Request $request)
    {
        $request = $request->only('token');
        try {
            $token = AccountService::checkToken($request['token']);
        return response()->json([
            'token' => $token,
        ],200);
        } catch (Exception $ex) {
            return $ex->getMessage();
        }

    }

    public function logout(Request $request)
    {
        $token = $request->bearerToken();
        $result = AccountService::logout($token);
        return $result;
    }




    public function refresh()
    {
        return response()->json([
            'status' => 'success',
            'user' => Auth::user(),
            'authorisation' => [
                'token' => Auth::refresh(),
                'type' => 'bearer',
            ]
        ]);
    }
}
