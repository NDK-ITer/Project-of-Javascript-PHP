<?php

namespace App\Http\Controllers;

use App\Services\FieldService;
use Illuminate\Http\Request;

class FieldController extends Controller
{
    public function get(Request $request)
    {
        $result = FieldService::get($request->all());
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = FieldService::get($request->all(), $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = FieldService::upload($request->all());
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = FieldService::upload($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = FieldService::delete($request->all(), $id);

        return $result;
    }
}
