<?php

namespace App\Services;

use App\Http\Resources\UserResource;
use App\Models\Employee;
use App\Models\Employer;
use App\Models\User;
use Exception;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Http\Request;
use Ramsey\Uuid\Uuid;
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
        $user = UserResource::make($user);
        return response()->json([
            'state' => 1,
            'token' => $token,
            'data' => $user,
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

        try {
            $validator = (new User())->validate($input);

        if ($validator != null) {
            return response()->json($validator);
        }

        $ds = array();
        $ds['email'] = $input['email'];
        $ds['password'] = $input['password'];
        $user = User::create($ds);
        $user->role_id = $input['roleId'];
        $user->save();
        $temp = UserService::getIdByEmail($user->email);
        if ($input['employer']) {



            $employer = array();
            $employer['companyName'] = $input['employer']['companyName'] ?? '';
            $employer['hotline']  = $input['employer']['hotline'] ?? '';
            $employer['address'] = $input['employer']['address'] ?? '';
            $employer['logo'] = '';
            $employer['description'] = '';
            $employer['created_at'] = date('Y-m-d H:i:s');
            $employer['updated_at'] = date('Y-m-d H:i:s');
            Employer::insert($employer + ['id' => $temp->id]);

        } else if($input['employee']) {
            $employee = array();
            $employee['fullname'] = $input['employee']['fullName'] ?? '';
            $employee['avatar']  = $input['employee']['avatar'] ?? '';
            $employee['phoneNumber '] = $input['employee']['phoneNumber'] ?? '';
            $employee['introduction'] = $input['employee']['introduction'] ?? '';
            $employee['certification'] = $input['employee']['certification'] ?? '';
            $employee['cv'] = $input['employee']['CV'] ?? '';
            $employee['gender'] = $input['employee']['gender'] ?? '';
            $employee['address'] = $input['employee']['address'] ?? '';
            $employee['born'] = $input['employee']['born'] ?? '';
            $employee['field_id'] = $input['employee']['fieldId'] ?? '';
            $employee['created_at'] = date('Y-m-d H:i:s');
            $employee['updated_at'] = date('Y-m-d H:i:s');
            Employee::insert($employee + ['id' => $temp->id]);
        } else {
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
        } catch (Exception $th) {
            echo $th;
        }
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
