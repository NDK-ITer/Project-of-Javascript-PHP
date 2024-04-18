<?php

namespace App\Http\Controllers;

use App\Services\Detail_RecruitmentService;
use Illuminate\Http\Request;

class Detail_RecruitmentController extends Controller
{
    public function get(Request $request)
    {
        $result = Detail_RecruitmentService::get($request->all());
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = Detail_RecruitmentService::get($request->all(), $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = Detail_RecruitmentService::upload($request->all());
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = Detail_RecruitmentService::upload($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = Detail_RecruitmentService::delete($request->all(), $id);
        return $result;
    }
}
