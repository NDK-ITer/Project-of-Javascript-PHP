<?php

namespace App\Http\Controllers;

use App\Services\RecruitmentArticleService;
use Illuminate\Http\Request;

class RecruitmentArticleController extends Controller
{
    public function getPublicAll(Request $request)
    {
        $result = RecruitmentArticleService::getPublicAll($request->all());
        return $result;
    }
    public function get(Request $request)
    {
        $result = RecruitmentArticleService::get($request->all());
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = RecruitmentArticleService::get($request->all(), $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = RecruitmentArticleService::upload($request->all());
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = RecruitmentArticleService::upload($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = RecruitmentArticleService::delete($request->all(), $id);
        return $result;
    }
}
