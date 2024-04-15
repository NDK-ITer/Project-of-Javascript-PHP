<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class RecruitmentArticleResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $data =  [
            'id' => $this->id,
            'name' => $this->name,
            'requirement' => $this->requirement,
            'description' => $this->description,
            'image' => $this->image,
            'salary' => $this->salary,
            'addressWork' => $this->addressWork,
            'isApproved' => $this->isApproved,
            'endSubmission' => $this->endSubmission,
            'ageEmployee' => $this->ageEmployee,
            'countEmployee' => $this->countEmployee,
            'formOfWork' => $this->formOfWork,
            'yearOfExpensive' => $this->yearsOfExperience,
            'degree' => $this->degree,
            'employer_id' => $this->employer_id,
            'field_id' => $this->field_id,
            'position' => $this->position,
            'dateUpload'=> $this->updated_at,
            'fieldName' => $this->whenLoaded('field', function () {
                return $this->field->name;
            })
        ];
        return $data;
        // return parent::toArray($request);
    }
}
