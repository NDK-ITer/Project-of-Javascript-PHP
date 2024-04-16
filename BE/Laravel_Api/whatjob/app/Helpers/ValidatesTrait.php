<?php
namespace App\Helpers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

trait ValidatesTrait{


    public function validate(array $data)
    {
        $validator = Validator::make($data, $this->rules ?? []);

        if ($validator->fails()) {
            $errors = $validator->errors()->toArray();

            return [
                'status' => 422,
                'errors' => $errors,
            ];
        }
        return null;
    }
}
