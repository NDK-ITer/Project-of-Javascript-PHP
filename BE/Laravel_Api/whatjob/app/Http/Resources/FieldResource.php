<?php

namespace App\Http\Resources;

use App\Models\Recruitment_Article;
use App\Models\RecruitmentArticle;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class FieldResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        // return parent::toArray($request);
        $recruitment_articles = RecruitmentArticle::where('field_id', $this->id)->get();
        $data = [
            'id' => $this->id,
            'name' => $this->name,
        ];
        $recruitment_articles = $this->whenLoaded('recruitmentarticles', function () {
            return $this->recruitmentarticles;
        });

        if ($recruitment_articles != null && count($recruitment_articles) > 0) {

            $data = array_merge($data, [
                'recruitmentaricle' => $recruitment_articles
            ]);
        }

        return $data;
    }
}
