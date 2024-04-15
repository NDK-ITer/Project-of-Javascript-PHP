<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Models\Employer;
use App\Models\Recruitment_Article;
use App\Models\RecruitmentArticle;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class RecruitmentArticleService
{
    public static function getPublicAll(array $data = null, $id = null)
    {
        try {

            $data = $data['data'] ?? $data;
            $query = Employer::query();
            // $relations = $data['populate'] ?? '';
            // $model =  $query->getModel();
            // $query = PopulateRelations::populateRelations($query, $relations, $model);

            $query = $query->with('recruitmentaricle');

            $employers = $query->get();
            $resultTmp = [];
            foreach ($employers as $employer) {
                // print_r($employer->recruitmentaricle->isApproved);

                if ((!$employer->recruitmentaricle || $employer->recruitmentaricle->count() > 0)) {

                    foreach($employer->recruitmentaricle as $article){
                        if($article->isApproved == 1){

                            $resultTmp[] = [
                                'id' => $article->id,
                                'companyName' => $employer->companyName,
                                'companyLogo' => $employer->logo,
                                'name' => $article->name,
                                'description' => $article->description,
                                'salary' => $article->salary,
                                'image' => $article->image,
                            ];
                        }
                    }
                }
            }
            $result = $resultTmp;

            $data = [
                'state' => 1,
                'mess' => "Get all data successfully",
                'data' => $result

            ];
            return $data;
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
                        "RecruitmentArticle" => $query
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
    public static function get(array $data = null, $id = null)
    {
        try {

            $data = $data['data'] ?? $data;
            $query = RecruitmentArticle::query();
            $relations = $data['populate'] ?? '';
            $model =  $query->getModel();

            $query = PopulateRelations::populateRelations($query, $relations, $model);
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
                        "RecruitmentArticle" => $query
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
            // $validator = (new RecruitmentArticle())->validate($data);
            // if ($validator != null) {
            //     return response()->json($validator);
            // }

            if ($id === null) {
                $ra = new RecruitmentArticle();
                // $role->id = Str::uuid()->toString();

                $message = 'Data update successfully';
            } else {
                $recruitment_article = RecruitmentArticle::find($id);

                if (!$recruitment_article) {
                    $data = [
                        'status' => 404,
                        'message' => "Data not found",
                    ];
                    return $data;
                }
                $message = 'Data uploaded successfully';
            }
            $fields = [
                'name',
                'requirement',
                'description',
                'image',
                'salary',
                'addressWork',
                'isApproved',
                'endSubmission',
                'ageEmployee',
                'countEmployee',
                'formOfWork',
                'yearsOfExperience',
                'degree',
                'employer_id',
                'field_id',
            ];
            foreach ($fields as $field) {
                $recruitment_article->$field = $data[$field] ?? $recruitment_article->$field;
            }
            $recruitment_article->save();

            $recruitment_article = RecruitmentArticle::get();

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
            echo $e->getMessage();
            return response()->json($data, $e->getCode());
        }
    }

    public static function delete(array $data = null, $id)
    {
        $recruitment_article = RecruitmentArticle::find($id);

        if ($recruitment_article) {
            $recruitment_article->delete();
            $recruitment_article = RecruitmentArticle::get($data);

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
