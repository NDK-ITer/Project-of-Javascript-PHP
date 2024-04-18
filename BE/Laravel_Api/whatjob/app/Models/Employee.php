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
        'fullName',
        'avatar',
        'phoneNumber',
        'introduction',
        'certification',
        'cV',
        'gender',
        'address',
        'born',
        'field_id',
    ];


    protected $rules = [
        // 'id' => 'required'
    ];

    public function user(){
        return $this->belongsTo(User::class, 'id', 'id');
    }

    public function field(){
        return $this->belongsTo(Field::class, 'field_id');
    }

}
