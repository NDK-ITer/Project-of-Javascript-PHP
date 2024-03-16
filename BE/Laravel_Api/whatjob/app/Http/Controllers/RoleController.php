<?php

namespace App\Http\Controllers;

use App\Models\Role;
use App\Services\RoleService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class RoleController extends Controller
{
    public function get(Request $request)
    {
        $result = RoleService::get($request);
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = RoleService::get($request, $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = RoleService::upload($request);
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = RoleService::upload($request, $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = RoleService::delete($request, $id);

        return $result;
    }
}
