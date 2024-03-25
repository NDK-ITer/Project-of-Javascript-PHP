<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class RoleResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return parent::toArray($request);
    }

    // public function toArray(Request $request): array
    // {
    //     //return parent::toArray($request);


    //     $data = [
    //         'id' => $this->id,
    //         'name' => $this->name,
    //         'email' => $this->email,
    //         'username' => $this->username,
    //         'email' => $this->email,
    //         'phonenumber' => $this->phonenumber,
    //         'provider' => $this->provider,
    //         'password' => $this->password,
    //         'resetPasswordToken' => $this->resetPasswordToken,
    //         'confirmationToken' => $this->confirmationToken,
    //         'confirmed' => $this->confirmed,
    //         'blocked' => $this->blocked,
    //         'city' => $this->city,
    //         'address' => $this->address,
    //         'role' => $this->role,
    //         // Thêm các trường khác nếu cần
    //     ];
    //     if ($this->employer != null) {
    //         $data['employer'] = $this->employer;
    //     }
    //     if ($this->employee != null) {
    //         $data['employee'] = $this->employee;
    //     }
    //     return $data;
    // }
}
