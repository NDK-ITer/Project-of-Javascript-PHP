<?php

namespace App\Services;

use App\Helpers\PopulateRelations;
use App\Http\Resources\RecruitmentArticleResource;
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
                $query = $query->with('field');
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
                $query = $query->with('field');
                $query = $query->find($id);

                $query = RecruitmentArticleResource::make($query);
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

    public static function upload(array $data = null, $id = null, $token = null)
    {

        try {
            // $validator = (new RecruitmentArticle())->validate($data);
            // if ($validator != null) {
            //     return response()->json($validator);
            // }
            list($headersB64, $payloadB64, $sig) = explode('.', $token);
            $decoded = json_decode(base64_decode($payloadB64), true);
            $employer_id = $decoded['id'];

            if ($id === null) {
                $recruitment_article = new RecruitmentArticle();
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
            $recruitment_article->name = $data['name'] ?? $recruitment_article->name;
            // $recruitment_article->requirement = $data['requirement'] ?? $recruitment_article->requirement ?? '';
            $recruitment_article->requirement = $data['requirement'] ?? '';
            $recruitment_article->description = $data['description'] ?? $recruitment_article->description;
            $recruitment_article->position = $data['position'] ?? $recruitment_article->position;
            $recruitment_article->image = $data['image'] ?? $recruitment_article->image ?? '';
            $recruitment_article->salary = $data['salary'] ?? $recruitment_article->salary;
            $recruitment_article->addressWork = $data['addressWork'] ?? $recruitment_article->addressWork;
            $recruitment_article->isApproved = $data['isApproved'] ?? 0;
            $recruitment_article->endSubmission = $data['endSubmission'] ?? $recruitment_article->endSubmission;
            $recruitment_article->ageEmployee = $data['ageEmployee'] ?? $recruitment_article->ageEmployee;
            $recruitment_article->countEmployee = $data['countEmployee'] ?? $recruitment_article->countEmployee;
            $recruitment_article->formOfWork = $data['formOfWork'] ?? $recruitment_article->formOfWork;
            $recruitment_article->yearsOfExperience = $data['yearOfExpensive'] ?? $recruitment_article->yearsOfExperience;
            $recruitment_article->degree = $data['degree'] ?? $recruitment_article->degree;
            $recruitment_article->field_id = $data['fieldId'] ?? $recruitment_article->field_id;
            $recruitment_article->employer_id = $employer_id ?? $recruitment_article->employer_id;
            $recruitment_article->save();

            // $recruitment_article = RecruitmentArticle::get();

            $data = [
                'state' => 1,
                'message' => $message,
                // 'data' => $recruitment_article
            ];

            return response()->json($data, 200);;
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
