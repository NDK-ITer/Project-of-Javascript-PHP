<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Ramsey\Uuid\Uuid;

class UserService
{
    public static function get(Request $request = null, $id = null)
    {
        try {
            $query = User::query();
            $relations = $request->input('populate');
            $model =  $query->getModel();

            $query = PopulateRelations::populateRelations($query, $relations, $model);



            if ($id === null) {
                $perpage  = $request->has('per_page') ? $request->input('per_page') : 10;
                $query = $query->paginate($perpage);
                //return $query->items();

                $data = [
                    'status' => 200,
                    'message' => "Get all data successfully",
                    'users' => $query,

                ];
            } else {
                $query = $query->find($id);
                if ($query) {

                    $data = [
                        'status' => 200,
                        'message' => "Get data successfully",
                        'users' => $query,
                    ];
                } else {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                        'users' => $query,
                    ];
                }
            }

            return response()->json($data, 200);
        } catch (Exception $e) {

            $data = [
                'status' => $e->getCode(),
                'message' => $e->getMessage(),
            ];

            return response()->json($data, $e->getCode());
        }
    }

    public static function upload(Request $request, $id = null)
    {

        try {

            $validator = (new User())->validate($request);

            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $user = new User;
                //$user->Id = Str::uuid()->toString();
                $message = 'Data update successfully';
            } else {
                $user = User::find($id);
                $message = 'Data uploaded successfully';
            }

            $user->Name = $request->Name;
            $user->FullName = $request->FullName;
            $user->Email = $request->Email;
            $user->Password = $request->Password;
            $user->Born = $request->Born;
            $user->IsBlock = $request->IsBlock;
            $user->role_id = '97fd62a1-000e-495f-b906-27dcce86f7d4';
            // $user->role_id = $request->role_id;
            $user->save();

            $users = RoleService::get($request);

            $data = [
                'status' => 200,
                'message' => $message,
                'data' => $users
            ];

            return $data;
        } catch (Exception $e) {

            $data = [
                'status' => $e->getCode(),
                'message' => $e->getMessage(),
            ];

            return response()->json($data, $e->getCode());
        }
    }

    public static function delete(Request $request, $id)
    {
        $user = User::find($id);

        if ($user) {
            $user->delete();
            $user = UserService::get($request);

            $data = [
                'status' => 200,
                'message' => "Data deleted successfully",
                'data' => $user
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
}
