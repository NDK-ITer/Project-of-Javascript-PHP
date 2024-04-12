<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\Role;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class RoleService
{
    public static function get(Request $request = null, $id = null)
    {

        try {
            $query = Role::query();
            $relations = $request->input('populate');
            $model =  $query->getModel();

            $query = PopulateRelations::populateRelations($query, $relations, $model);

            if ($id === null) {
                $limit = 10;
                $page =  $request->input('page');
                $query = $query->paginate($limit , ['*'], 'page', $page);

                $query = $query->items();

                $data = [
                    'status' => 200,
                    'message' => "Get all data successfully",
                    'roles' => collect($query)->keyBy('normalizeName')->mapWithKeys(function ($item) {
                        return [$item['normalizeName'] => $item];
                    })->toArray(),
                ];
            } else {
                $query = $query->find($id);
                if ($query) {

                    $data = [
                        'status' => 200,
                        'message' => "Get data successfully",
                        'data' => $query,
                    ];
                } else if ($id != null) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                        'roles' => $query,
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

            $validator = (new Role())->validate($request->all());

            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $role = new Role;
                $role->id = Str::uuid()->toString();

                $message = 'Data update successfully';
            } else {
                $role = Role::find($id);
                $message = 'Data uploaded successfully';
            }

            $role->name = $request->name;
            $role->normalizeName = ltrim(strtolower($request->name));
            $role->save();

            $roles = RoleService::get($request);

            $data = [
                'status' => 200,
                'message' => $message,
                'data' => $roles
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
        $role = Role::find($id);

        if ($role) {
            $role->delete();
            $roles = RoleService::get($request);

            $data = [
                'status' => 200,
                'message' => "Data deleted successfully",
                'data' => $roles
            ];
        } else {
            $data = [
                'status' => 404,
                'message' => "Data not found",
            ];
        }
        return response()->json($data, 200);
    }
}
