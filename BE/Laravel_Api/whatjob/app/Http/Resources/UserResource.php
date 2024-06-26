<?php

namespace App\Http\Resources;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */


    public function toArray(Request $request): array
    {
        // return parent::toArray($request);
        // $user = User::find($this->Id);
        $data = [
            // 'w' =>$this->employee,
            'id' => $this->id,
            'email' => $this->email,
            'password' => $this->password,
            'isBlock' => $this->isBlock,
            'role' => $this->role->name,
            'roleId' => $this->role_id,
            // Thêm các trường khác nếu cần
        ];
        if ($this->employee != null) {
            $employee = $this->whenLoaded('employee', function () {
                return $this->employee;
            });
            $data = array_merge($data, [
                'fullname' => $employee->fullname,
                'avatar' => $employee->avatar,
                'phoneNumber' => $employee->phoneNumber,
                'introduction' => $employee->introduction,
                'certification' => $employee->certification,
                'cv' => $employee->cv,
                'gender' => $employee->gender,
                'address' => $employee->address,
                'born' => $employee->born,
            ]);
        }
        if ($this->employer != null) {
            $employer = $this->whenLoaded('employer', function () {
                return $this->employer;
            });
            $data = array_merge($data, [
                'companyName' => $employer->companyName,
                'logo' => $employer->logo,
                'description' => $employer->description,
                'hotline' => $employer->hotline,
                'address' => $employer->address,
            ]);
        }

        return $data;
    }

    // additional
    public $additional;

    function additional(array $data)
    {
        return parent::additional($data); // TODO: Change the autogenerated stub
    }

    /**
     * @return array
     */
    public function getAdditional(): array
    {
        return $this->additional;
    }

    /**
     * @param mixed $additional
     */
    public function setAdditional($additional)
    {
        $this->additional = $additional;
    }
}
