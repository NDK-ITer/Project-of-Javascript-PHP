<?php

namespace App\Models;

use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Enjoy extends Model
{
    use HasFactory, HasUuids;
    use RelationshipsTrait, ValidatesTrait;

    protected $fillable = [
        //'id',
        'employee_id',
        'recruitment_article_id'
    ];

    protected $rules = [
        'name' => 'required'
    ];

    public function recruitment_aricle(){
        return $this->hasOne(Recruitment_Article::class);
    }

    public function employee(){
        return $this->hasOne(Employee::class);
    }
}
