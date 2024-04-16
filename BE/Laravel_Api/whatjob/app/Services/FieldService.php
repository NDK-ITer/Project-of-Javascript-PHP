<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Http\Resources\FieldResource;
use App\Models\Field;
use App\Models\Recruitment_Article;
use App\Models\Role;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class FieldService
{
    public static function get(array $data = null, $id = null)
    {

        try {

            $data = $data['data'] ?? $data;
            $query = Field::query();
            $relations = $data['populate'] ?? '';
            $model =  $query->getModel();
            $query = PopulateRelations::populateRelations($query, $relations, $model);


            if($relations != '' && ($relations == '*' || $relations == 'recruitmentarticles')){
                $query = Field::with(['recruitmentarticles']);
            }

            if ($id === null) {
                // $limit = 10;
                // $page =  $data['page'] ?? 1;
                // $query = $query->paginate($limit, ['*'], 'page', $page);
                // $query = $query->items();
                // $query = $query->with('recruitmentarticles');
                $query = $query->get();

                // $query = FieldResource::collection($query);
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
            $validator = (new Field())->validate($data);
            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $field = new Field();
                // $role->id = Str::uuid()->toString();

                $message = 'Data update successfully';
            } else {
                $field = Field::find($id);

                if (!$field) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                }
                $message = 'Data uploaded successfully';
            }
            $field->name = $data['name'];
            $field->save();
            $fields = FieldService::get($data);

            $data = [
                'status' => 200,
                'message' => $message,
                'data' => $fields
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
        $field = Field::find($id);

        if ($field) {
            $field->delete();
            $fields = FieldService::get($data);

            $data = [
                'status' => 200,
                'message' => "Data deleted successfully",
                'data' => $fields
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
