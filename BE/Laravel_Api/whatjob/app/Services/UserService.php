<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\User;
use DateTime;
use Exception;
use Illuminate\Http\Request;
use Ramsey\Uuid\Uuid;

class UserService
{

    public static function get_data(){
        $query = User::query();
        return $query->get();;
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

                // $perpage  = $data['per_page'] ?? 10;
                // $query = $query->paginate($perpage);

                $query = $query->get();
                $data = [
                    'status' => 200,
                    'mess' => "Get all data successfully",
                    'data' => [
                        "users" => $query
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

            $validator = (new User())->validate($data);

            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $user = new User;
                //$user->Id = Str::uuid()->toString();
                $mess = 'Data update successfully';
            } else {
                $user = User::find($id);
                $mess = 'Data uploaded successfully';
            }

            $user->FullName =  $data['FullName'] ?? $user->FullName;
            $user->Email = $data['Email'] ?? $user->Email;
            $user->Password = $data['Password'] ?? $user->Password;
            $user->Born = $data['Born'] ?? $user->Born;
            $user->IsBlock = $data['IsBlock'] ?? 0;
            $user->role_id = $data['RoleId'] ?? '97fd62a1-000e-495f-b906-27dcce86f7d4';
            // $user->role_id = $data['RoleId'] ;
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

            $data = [
                'status' => $e->getCode(),
                'mess' => $e->getMessage(),
            ];

            return response()->json($data, $e->getCode());
        }
    }

    public static function delete(Request $request, $id)
    {
        $user = User::find($id);

        if ($user) {
            $user->delete();
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
}
