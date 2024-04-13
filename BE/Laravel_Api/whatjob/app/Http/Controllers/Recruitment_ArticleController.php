<?php

namespace App\Http\Controllers;

use App\Services\Recruitment_ArticleService;
use Illuminate\Http\Request;

class Recruitment_ArticleController extends Controller
{
    public function get(Request $request)
    {
        $result = Recruitment_ArticleService::get($request->all());
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = Recruitment_ArticleService::get($request->all(), $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = Recruitment_ArticleService::upload($request->all());
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = Recruitment_ArticleService::upload($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = Recruitment_ArticleService::delete($request->all(), $id);
        return $result;
    }
}
