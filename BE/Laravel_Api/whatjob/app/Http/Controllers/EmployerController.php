<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\EmployerService;

class EmployerController extends Controller
{
    public function get(Request $request)
    {
        $result = EmployerService::get($request->all());
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = EmployerService::get($request->all(), $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = EmployerService::upload($request->all());
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = EmployerService::upload($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = EmployerService::delete($request->all(), $id);
        return $result;
    }
}
