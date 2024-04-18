<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Http\Resources\UserResource;
use App\Models\User;
use DateTime;
use Exception;
use Illuminate\Http\Request;
use Ramsey\Uuid\Uuid;

class UserService
{

    public static function get_data()
    {
        $query = User::query();
        return $query->get();;
    }

    public static function getIdByEmail($email)
    {
        return $user = User::where('email', $email)->first();
    }

    public static function get(array $data = [], $id = null)
    {

        try {
            $data = $data['data'] ?? $data;
            $query = User::query();
            $relations = $data['populate'] ?? '';
            $model =  $query->getModel();

            $query = PopulateRelations::populateRelations($query, $relations, $model);

            if (!$id) {
                $limit = 10;
                $page =  $data['page'] ?? 1;
                $query = $query->paginate($limit, ['*'], 'page', $page);


                $query = $query->items();

                // return UserResource::collection($query);
                $users = UserResource::collection($query);
                $data = [
                    'status' => 200,
                    'mess' => "Get all data successfully",
                    'data' => [
                        "users" => $users
                    ],

                ];
            } else {
                $query = $query->find($id);
                if ($query) {

                    $data = [
                        'status' => 200,
                        'mess' => "Get data successfully",
                        'data' => [
                            "users" => $query
                        ],
                    ];
                } else {
                    $data = [
                        'status' => 404,
                        'mess' => "Data not found",
                        'data' => [
                            "users" => $query
                        ],
                    ];
                }
            }

            return response()->json($data, 200);
        } catch (Exception $e) {
            echo ($e);
            $data = [
                'status' => $e->getCode(),
                'mess' => $e->getMessage(),
            ];

            return response()->json($data, $e->getCode());
        }
    }


    public static function upload(array $data, $id = null)
    {

        try {

            // $validator = (new User())->validate($data);

            // if ($validator != null) {
            //     return response()->json($validator);
            // }

            if ($id === null) {
                $user = new User;
                $user->id = Uuid::uuid4()->toString();
                $mess = 'Data update successfully';
            } else {
                $user = User::find($id);
                $mess = 'Data uploaded successfully';
            }

            $user->email = $data['email'] ?? $user->email;
            $user->password = $data['password'] ?? $user->password;
            // $user->isBlock = $data['isBlock'] ?? !$user->isBlock;
            // $user->role_id = $data['roleId'] ?? '97fd62a1-000e-495f-b906-27dcce86f7d4';
            // $user->role_id = $data['roleId'] ;
            $user->save();
            $users = UserService::get_data();

            $data = [
                'status' => 200,
                'mess' => $mess,
                'data' => [
                    "users" => $users
                ],
            ];

            return $data;
        } catch (Exception $e) {
            echo $e->getMessage();
            $data = [
                'status' => $e->getCode(),
                'mess' => $e->getMessage(),
            ];
            return response()->json($data, $e->getCode());
        }
    }

    public static function delete(array $data = [], $id)
    {
        $user = User::find($id);

        if ($user) {
            if (!$user->delete()) {
                $data = [
                    'status' => 500,
                    'mess' => "Data deleted unsuccessfully",
                ];
            }
            $users = UserService::get_data();

            $data = [
                'status' => 200,
                'mess' => "Data deleted successfully",
                'data' => [
                    "users" => $users
                ],
            ];
        } else {
            $data = [
                'status' => 404,
                'mess' => "Data not found",
            ];
        }

        return response()->json($data, 200);
    }

    public static function lock(array $data = [], $id)
    {
        $user = User::find($id);

        if ($user) {
            $user->IsBlock = 1;
            $user->save();
            // $users = UserService::get_data();
            $data = [
                'status' => 200,
                'mess' => "Data deleted successfully",
                'data' => [
                    "user" => $user
                ],
            ];
        } else {
            $data = [
                'status' => 404,
                'message' => "Data not found",
            ];
        }

        return response()->json($data, 200);
    }

    public static function update_expired(User $user, $token)
    {
        try {
            $token_id = AccountService::getIdToken($token);
            $user->token_id = $token_id;
            $user->save();
            return true;
        } catch (Exception $ex) {
            echo $ex;
            return false;
        }
    }

    public static function delete_token(User $user)
    {
        try {
            $token_id = '';
            $user->token_id = $token_id;
            $user->save();
            return true;
        } catch (Exception $ex) {
            echo $ex;
            return false;
        }
    }

    public static function uploadFile($request, $folder, $name)
    {
        if ($request->hasFile($name)) {
            $file = $request->file($name);
            $nameFile = $file->getClientOriginalName();
            $file->move('uploads/' . $folder, $nameFile);

            return 'uploads/' . $folder . '/' . $nameFile;
        }

        return null;
    }

}
