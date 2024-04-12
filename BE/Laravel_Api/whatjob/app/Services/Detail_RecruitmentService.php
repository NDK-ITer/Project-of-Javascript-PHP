<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\Detail_Recruitment;
use App\Models\Employer;
use App\Models\Enjoy;
use App\Models\User;
use Exception;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Illuminate\Http\Request;
use Ramsey\Uuid\Type\Integer;

class Detail_RecruitmentService
{
    public static function get(array $data = null, $id = null)
    {
        try {

            $data = $data['data'] ?? $data;
            $query = Detail_Recruitment::query();
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
                        "detail_recruitments" => $query
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

            $validator = (new Detail_Recruitment())->validate($data);

            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $detail_recruitment = new Detail_Recruitment;
                $detail_recruitment->id = $data['id'];
            } else {
                $detail_recruitment = Detail_Recruitment::find($id);
                if (!$detail_recruitment) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                    return response()->json($data, 404);
                }
            }
            $data = $data ?? [];
            $detail_recruitment->employee_id = $data['employeeId'] ?? $detail_recruitment->employee_id;
            $detail_recruitment->recruitment_article_id = $data['recruitmentArticleId'] ?? $detail_recruitment->recruitment_article_id;
            if (!$detail_recruitment->save()) {
                return response()->json([
                    'status' => 500,
                    'message' => $detail_recruitment->getErrors(),
                ], 500);
            }

            $detail_recruitment = Detail_RecruitmentService::get($data);

            $data = [
                'status' => 200,
                'message' => $id === null ? 'Data uploaded successfully' : 'Data update successfully',
                'data' => $detail_recruitment
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
        $detail_recruitment = Detail_Recruitment::find($id);
        if($detail_recruitment){
            $detail_recruitment->IsBlock = !$detail_recruitment->IsBlock->toString;
            $detail_recruitment->save();
            $data = [
                'status' => 200,
                'mess' => "Data deleted successfully",
                'data' => [
                    "detail_recruitment" => $detail_recruitment
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
