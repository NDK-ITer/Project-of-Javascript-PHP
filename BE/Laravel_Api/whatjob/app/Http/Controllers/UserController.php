<?php

namespace App\Http\Controllers;

use App\Services\UserService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    //
    public function get(Request $request)
    {
        $data = $request->only(['populate', 'per_page']);
        $result = UserService::get($request->all());
        return $result;
    }

    public function show(Request $request, $id)
    {
        $data = $request->only(['populate', 'per_page']);
        $result = UserService::get($request->all(), $id);
        return $result;
    }

    public function upload(Request $request)
    {
        // $data = $request->only(['Name', 'FullName', 'Email', 'Password', 'Born', 'IsBlock',"RoleId"]);
        $result = UserService::upload($request->all());
        return $result;
    }

    public function edit(Request $request, $id)
    {
        // $data = $request->only(['Name', 'FullName', 'Email', 'Password', 'Born', 'IsBlock',"RoleId"]);
        $result = UserService::upload($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = UserService::delete($request, $id);

        return $result;
    }
}
