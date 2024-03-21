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
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = Auth::login($user);
        return response()->json([
            'status' => 'success',
            'message' => 'User created successfully',
            'user' => $user,
            'authorisation' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ]);
    }


    public function login(Request $request)
    {
        // Get the login credentials from the request.
        $credentials = $request->only('Email', 'Password');


        $result = AccountService::login($credentials);

        return $result;
    }



    public function checkToken(Request $request)
    {
        $request = $request->only('Token');
        try {
            $token = AccountService::checkToken($request['Token']);
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
