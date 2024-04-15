<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\Employer;
use App\Models\User;
use Exception;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Http\Request;
use Ramsey\Uuid\Type\Integer;

class EmployerService
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
                $query = Employer::query();
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
            $query = Employer::query();
            $relations = $data['populate'] ?? '';
            $model =  $query->getModel();
            return $query->get();
            $query = PopulateRelations::populateRelations($query, $relations, $model);

            if ($id === null) {
                // $perpage  = $request->has('per_page') ? $request->input('per_page') : 10;
                // $query = $query->paginate($perpage);
                //return $query->items();

                // $query = $query->get();

                $query = $query->get();
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

            $validator = (new Employer())->validate($data);

            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $employer = new Employer;
                $employer->id = $data['id'];
            } else {
                $employer = Employer::find($id);
                if (!$employer) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                    return response()->json($data, 404);
                }
            }
            $data = $data ?? [];
            $employer->id = $data['id'] ?? $employer->id;
            $employer->companyName = $data['companyName'] ?? $employer->companyName;
            $employer->logo = $data['logo'] ?? $employer->logo;
            $employer->description = $data['description'] ?? $employer->description;
            $employer->hotline = $data['hotline'] ?? $employer->hotline;
            $employer->address = $data['address'] ?? $employer->address;
            if (!$employer->save()) {
                return response()->json([
                    'status' => 500,
                    'message' => $employer->getErrors(),
                ], 500);
            }

            $employers = EmployerService::get($data);

            $data = [
                'status' => 200,
                'message' => $id === null ? 'Data uploaded successfully' : 'Data update successfully',
                'data' => $employers
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

    public static function delete(array $data = null, $id)
    {
        $user = User::find($id);
        if ($user) {
            $user->IsBlock = !$user->IsBlock->toString;
            $user->save();
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
}
