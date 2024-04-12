<?php

namespace App\Models;

use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employer extends Model
{
    use HasFactory, HasUuids;
    use RelationshipsTrait, ValidatesTrait;


    protected $fillable = [
        //'id',
        'companyName',
        'logo',
        'description',
        'hotline',
        'address',
    ];

    protected $rules = [
        // 'id' => 'required'
    ];

    public function user(){
        return $this->hasOne(User::class);
    }

    public function recruitment_aricle(){
        return $this->hasMany(Recruitment_Aricle::class);
    }
}
