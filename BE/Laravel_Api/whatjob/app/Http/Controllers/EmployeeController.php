<?php

namespace App\Http\Controllers;

use App\Services\EmployeeService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Psy\Readline\Hoa\Console;

class EmployeeController extends Controller
{
    public function me(Request $request)
    {
        $token = $request->bearerToken('token');
        $result = EmployeeService::me($request->all(), $token);
        return $result;
    }
    public function get(Request $request)
    {
        $result = EmployeeService::get($request->all());
        return $result;
    }

    public function show(Request $request, $id)
    {
        $result = EmployeeService::get($request->all(), $id);
        return $result;
    }

    public function upload(Request $request)
    {
        $result = EmployeeService::upload($request->all());
        return $result;
    }

    public function edit(Request $request, $id)
    {
        $result = EmployeeService::upload($request->all(), $id);
        return $result;
    }

    public function edit_1(Request $request)
    {
        $token = $request->bearerToken('token');
        list($headersB64, $payloadB64, $sig) = explode('.', $token);
        $decoded = json_decode(base64_decode($payloadB64), true);
        $id = $decoded['id'];
        if (!$id) {

        }
        Log::info("Edit Employee ID: $id, Request: " . json_encode($request->all()) . ", Decoded: " . json_encode($decoded));

        $result = EmployeeService::edit($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = EmployeeService::delete($request->all(), $id);
        return $result;
    }
}
