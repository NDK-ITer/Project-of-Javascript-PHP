<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\EmployerService;
use Illuminate\Support\Facades\Log;

class EmployerController extends Controller
{
    public function me(Request $request)
    {
        $token = $request->bearerToken('token');
        $result = EmployerService::me($request->all(), $token);
        return $result;
    }
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

    public function edit_1(Request $request)
    {
        $token = $request->bearerToken('token');
        list($headersB64, $payloadB64, $sig) = explode('.', $token);
        $decoded = json_decode(base64_decode($payloadB64), true);
        $id = $decoded['id'];
        echo $id;
        // if (!$id) {

        // }
        // Log::info("Edit Employee ID: $id, Request: " . json_encode($request->all()) . ", Decoded: " . json_encode($decoded));

        // $result = EmployerService::edit($request->all(), $id);
        return $id;
    }

    public function edit(Request $request, $id)
    {
        if ($id == 'edit') {
            $token = $request->bearerToken('token');
            list($headersB64, $payloadB64, $sig) = explode('.', $token);
            $decoded = json_decode(base64_decode($payloadB64), true);
            $id = $decoded['id'];
        }
        $result = EmployerService::upload($request->all(), $id);
        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = EmployerService::delete($request->all(), $id);
        return $result;
    }
}
