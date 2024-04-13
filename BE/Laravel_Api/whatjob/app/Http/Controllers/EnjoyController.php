<?php

namespace App\Http\Controllers;

use App\Services\EnjoyService;
use Illuminate\Http\Request;

class EnjoyController extends Controller
{
    public function get(Request $request)
    {
        $result = EnjoyService::get($request->all());
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = EnjoyService::get($request->all(), $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = EnjoyService::upload($request->all());
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = EnjoyService::upload($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = EnjoyService::delete($request->all(), $id);
        return $result;
    }
}
