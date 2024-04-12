<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\Employer;
use App\Models\Enjoy;
use App\Models\User;
use Exception;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Http\Request;
use Ramsey\Uuid\Type\Integer;

class EnjoyService
{
    public static function get(array $data = null, $id = null)
    {
        try {

            $data = $data['data'] ?? $data;
            $query = Enjoy::query();
            $relations = $data['populate'] ?? '';
            $model =  $query->getModel();

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
                        "enjoys" => $query
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

            $validator = (new Enjoy())->validate($data);

            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $enjoy = new Enjoy;
                $enjoy->id = $data['id'];
            } else {
                $enjoy = Enjoy::find($id);
                if (!$enjoy) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                    return response()->json($data, 404);
                }
            }
            $data = $data ?? [];
            $enjoy->employee_id = $data['employeeId'] ?? $enjoy->companyName;
            $enjoy->recruitment_article_id = $data['recruitmentArticleId'] ?? $enjoy->logo;
            if (!$enjoy->save()) {
                return response()->json([
                    'status' => 500,
                    'message' => $enjoy->getErrors(),
                ], 500);
            }

            $enjoys = EnjoyService::get($data);

            $data = [
                'status' => 200,
                'message' => $id === null ? 'Data uploaded successfully' : 'Data update successfully',
                'data' => $enjoys
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
        $enjoy = Enjoy::find($id);
        if($enjoy){
            $enjoy->IsBlock = !$enjoy->IsBlock->toString;
            $enjoy->save();
            $data = [
                'status' => 200,
                'mess' => "Data deleted successfully",
                'data' => [
                    "enjoy" => $enjoy
                ],
            ];
        }
        else{
            $data = [
                'status' => 404,
                'message' => "Data not found",
            ];
        }
        return response()->json($data, 200);
    }
}
