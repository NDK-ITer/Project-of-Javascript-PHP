<?php

namespace App\Http\Controllers;

use App\Services\UserService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    //
    public function get(Request $request)
    {
        $result = UserService::get($request);
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = UserService::get($request, $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = UserService::upload($request);
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = UserService::upload($request, $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = UserService::delete($request, $id);

        return $result;
    }
}
