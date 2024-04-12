<?php

namespace App\Models;

use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    use HasFactory, HasUuids;
    use RelationshipsTrait, ValidatesTrait;


    protected $fillable = [
        //'id',
        'FullName',
        'Avatar',
        'PhoneNumber',
        'Introduction',
        'Certification',
        'CV',
        'Gender',
        'Address',
        'Born',
        'field_id',
    ];


    protected $rules = [
        // 'id' => 'required'
    ];

    public function user(){
        return $this->hasOne(User::class, 'id', 'id');
    }

}
