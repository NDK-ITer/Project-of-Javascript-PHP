<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\Employee;
use App\Models\User;
use Exception;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Http\Request;
use Ramsey\Uuid\Type\Integer;

class EmployeeService
{
    public static function get(array $data = null, $id = null)
    {
        try {

            $data = $data['data'] ?? $data;
            $query = Employee::query();
            $relations = $data['populate'] ?? '';
            $model =  $query->getModel();

            $query = PopulateRelations::populateRelations($query, $relations, $model);
            $employee = Employee::find($id);
            return $employee->user;
            if ($id === null) {
                $limit = 10;
                $page =  $data['page'] ?? 1;
                $query = $query->paginate($limit , ['*'], 'page', $page);


                $query = $query->items();


                // $query = $query->get();
                $data = [
                    'status' => 200,
                    'mess' => "Get all data successfully",
                    'data' => [
                        "fields" => $query
                    ],

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
                        'data' => $query,
                    ];
                }
            }

            return response()->json($data, 200);
        } catch (Exception $e) {
            echo $e->getMessage();
            $data = [
                'status' => $e->getCode(),
                'message' => $e->getMessage(),
            ];

            return response()->json($data, $e->getCode());
        }
    }

    public static function upload(array $data = null, $id = null)
    {
        try {

            $validator = (new Employee())->validate($data);

            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $employee = new Employee;
                $employee->id = $data['id'];
            } else {
                $employee = Employee::find($id);
                if (!$employee) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                    return response()->json($data, 404);
                }
            }

            $data = $data ?? [];
            $employee->field_id = $data['fieldId'] ?? null;
            if (!$employee->save()) {
                return response()->json([
                    'status' => 500,
                    'message' => $employee->getErrors(),
                ], 500);
            }

            $employees = EmployeeService::get($data);

            $data = [
                'status' => 200,
                'message' => $id === null ? 'Data uploaded successfully' : 'Data update successfully',
                'data' => $employees
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

    public static function delete(array $data = null, $id)
    {
    }
}
