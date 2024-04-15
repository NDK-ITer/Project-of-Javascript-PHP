<?php

namespace App\Models;

use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RecruitmentArticle extends Model
{
    use HasFactory, HasUuids;
    use RelationshipsTrait, ValidatesTrait;

    protected $table = 'recruitmentarticles';


    protected $fillable = [
        'id',
        'name',
        'requirement',
        'description',
        'image',
        'salary',
        'addressWork',
        'isApproved',
        'endSubmission',
        'ageEmployee',
        'countEmployee',
        'formOfWork',
        'yearsOfExperience',
        'degree',
        'employer_id',
        'field_id',
    ];

    public function employer()
    {
        return $this->belongsTo(Employer::class);
    }

    public function field()
    {
        return $this->belongsTo(Field::class, 'field_id');
    }
}
