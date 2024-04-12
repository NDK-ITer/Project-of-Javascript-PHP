<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\Recruitment_Article;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class Recruitment_ArticleService
{
    public static function get(array $data = null, $id = null)
    {

        try {

            $data = $data['data'] ?? $data;
            $query = Recruitment_Article::query();
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
                        "Recruitment_Article" => $query
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
            $validator = (new Recruitment_Article())->validate($data);
            if ($validator != null) {
                return response()->json($validator);
            }

            if ($id === null) {
                $ra = new Recruitment_Article();
                // $role->id = Str::uuid()->toString();

                $message = 'Data update successfully';
            } else {
                $recruitment_article = Recruitment_Article::find($id);

                if (!$recruitment_article) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                }
                $message = 'Data uploaded successfully';
            }
            $recruitment_article->name = $data['name'] ?? $recruitment_article->name;
            $recruitment_article->requirement = $data['requirement'] ?? $recruitment_article->requirement;
            $recruitment_article->description = $data['description'] ?? $recruitment_article->description;
            $recruitment_article->image = $data['image'] ?? $recruitment_article->image;
            $recruitment_article->salary = $data['salary'] ?? $recruitment_article->salary;
            $recruitment_article->addressWork = $data['addressWork'] ?? $recruitment_article->addressWork;
            $recruitment_article->isApproved = $data['isApproved'] ?? $recruitment_article->isApproved;
            $recruitment_article->endSubmission = $data['endSubmission'] ?? $recruitment_article->endSubmission;
            $recruitment_article->ageEmployee = $data['ageEmployee'] ?? $recruitment_article->ageEmployee;
            $recruitment_article->countEmployee = $data['countEmployee'] ?? $recruitment_article->countEmployee;
            $recruitment_article->formOfWork = $data['formOfWork'] ?? $recruitment_article->formOfWork;
            $recruitment_article->yearsOfExperience = $data['yearsOfExperience'] ?? $recruitment_article->yearsOfExperience;
            $recruitment_article->degree = $data['degree'] ?? $recruitment_article->degree;
            $recruitment_article->employer_id = $data['employer_id'] ?? $recruitment_article->employer_id;
            $recruitment_article->field_id = $data['field_id'] ?? $recruitment_article->field_id;
            $recruitment_article->save();

            $recruitment_article = Recruitment_Article::get($data);

            $data = [
                'status' => 200,
                'message' => $message,
                'data' => $recruitment_article
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
        $recruitment_article = Recruitment_Article::find($id);

        if ($recruitment_article) {
            $recruitment_article->delete();
            $recruitment_article = Recruitment_Article::get($data);

            $data = [
                'status' => 200,
                'message' => "Data deleted successfully",
                'data' => $recruitment_article
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
