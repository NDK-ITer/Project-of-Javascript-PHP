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

    public static function me(array $data = null, $token = null)
    {
        $JWT_SECRET = "KKtceSicihJCPRp0DnqipgAr1pL3VRvvKRxcjtYW52zsKdSerAoZkgoD58Dww54P";
        try {

            // $data = $data['data'] ?? $data;
            // $query = Employer::query();
            // $relations = $data['populate'] ?? '';
            // $model =  $query->getModel();
            // $query = PopulateRelations::populateRelations($query, $relations, $model);
            list($headersB64, $payloadB64, $sig) = explode('.', $token);
            $decoded = json_decode(base64_decode($payloadB64), true);

            if ($decoded['id']) {
                // $user = User::with('employer');
                // $user = $user->find($decoded['id']);
                // $query  = $user;
                $query = Employee::query();
                $query = $query->find($decoded['id']);
                // print_r($query);
                $data = [
                    'status' => 200,
                    'mess' => "Get all data successfully",
                    'data' => $query
                ];
                if (!$query) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                }
            } else {
                $data = [
                    'status' => 404,
                    'message' => "Data not found",
                ];
            }
            return $data;
            // if ($id === null) {

            //     $query = $query->get();
            //     $data = [
            //         'status' => 200,
            //         'mess' => "Get all data successfully",
            //         'data' => [
            //             "fields" => $query
            //         ],

            //     ];
            // } else {
            // $query = $query->find($id);
            // }$data = [
            //     'status' => 404,
            //     'message' => "Data not found",
            //     'data' => $query,
            // ];
            // }

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

    public static function get(array $data = null, $id = null)
    {
        try {

            $data = $data['data'] ?? $data;
            $query = Employee::query();
            $relations = $data['populate'] ?? '';
            $model =  $query->getModel();

            $query = PopulateRelations::populateRelations($query, $relations, $model);
            return $query->get();
            if ($id === null) {
                $limit = 10;
                $page =  $data['page'] ?? 1;
                $query = $query->paginate($limit, ['*'], 'page', $page);


                $query = $query->items();


                // $query = $query->get();
                $data = [
                    'status' => 200,
                    'mess' => "Get all data successfully",
                    'data' => [
                        "employees" => $query
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
                // $employee->id = $data['id'];
            } else {
                $employee = Employee::find($id);
                if (!$employee) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                    return response()->json($data, 404);
                }
                $employee->fullname = $data['fullName'] ?? $employee->fullname;
                $employee->avatar = $data['avatar'] ?? $employee->avatar;
                $employee->phoneNumber = $data['phoneNumber'] ?? $employee->phoneNumber;
                $employee->introduction = $data['introduction'] ?? $employee->introduction;
                $employee->certification = $data['certification'] ?? $employee->certification;
                $employee->cv = $data['CV'] ?? $employee->cv;
                $employee->gender = $data['gender'] ?? $employee->gender;
                $employee->address = $data['address'] ?? $employee->address;
                $employee->born = $data['born'] ?? $employee->born;
                $employee->field_id = $data['fieldId'] ?? $employee->field_id;
                $employee->updated_at = date('Y-m-d H:i:s');

                $employee->save();
            }

            // $data = $data ?? [];
            // $employee->field_id = $data['fieldId'] ?? null;
            // if (!$employee->save()) {
            //     return response()->json([
            //         'status' => 500,
            //         'message' => $employee->getErrors(),
            //     ], 500);
            // }

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
            echo $e->getMessage();
            return response()->json($data, $e->getCode());
        }
    }


    public static function edit(array $data = null, $id = null)
    {
        try {
$temp = $data;
            $employee = Employee::find($id);
                if (!$employee) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                    return response()->json($data, 404);
                }
                $employee->fullname = $data['fullName'] ?? $employee->fullname;
                $employee->avatar = $data['avatar'] ?? $employee->avatar;
                $employee->phoneNumber = $data['phoneNumber'] ?? $employee->phoneNumber;
                $employee->introduction = $data['introduction'] ?? $employee->introduction;
                $employee->certification = $data['certification'] ?? $employee->certification;
                $employee->cv = $data['CV'] ?? $employee->cv;
                $employee->gender = $data['gender'] ?? $employee->gender;
                $employee->address = $data['address'] ?? $employee->address;
                $employee->born = $data['born'] ? date('Y-m-d', strtotime($data['born'])) : $employee->born;
                $employee->field_id = $data['fieldId'] ?? $employee->field_id;
                $employee->updated_at = date('Y-m-d H:i:s');

                $employee->save();

            // $data = $data ?? [];
            // $employee->field_id = $data['fieldId'] ?? null;
            // if (!$employee->save()) {
            //     return response()->json([
            //         'status' => 500,
            //         'message' => $employee->getErrors(),
            //     ], 500);
            // }

            $employees = EmployeeService::get($data);

            $data = [
                'status' => 200,
                'message' => 'Data update successfully',
                'data' => $temp
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
