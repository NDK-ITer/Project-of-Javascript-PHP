<?php

namespace App\Models;

use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Field extends Model
{
    use HasFactory, HasUuids;
    use RelationshipsTrait, ValidatesTrait;

    protected $fillable = [
        //'id',
        'Name',
    ];

    protected $rules = [
        'name' => 'required'
    ];
}
