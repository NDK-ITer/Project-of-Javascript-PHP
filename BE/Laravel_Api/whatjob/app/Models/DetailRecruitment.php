<?php

namespace App\Models;

use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Detail_Recruitment extends Model
{
    use HasFactory, HasUuids;
    use RelationshipsTrait, ValidatesTrait;

    protected $fillable = [
        //'id',
        'employee_id',
        'recruitmentarticle_id'
    ];

    protected $rules = [
        'name' => 'required'
    ];

    public function recruitmentaricle(){
        return $this->hasOne(RecruitmentArticle::class);
    }

    public function employee(){
        return $this->hasOne(Employee::class);
    }
}
