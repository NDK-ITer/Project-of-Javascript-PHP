<?php

namespace App\Models;

use App\Helpers\RelationshipsTrait;
use App\Helpers\ValidatesTrait;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class Role extends Model
{
    use HasFactory, HasUuids;
    use RelationshipsTrait, ValidatesTrait;

    protected $fillable = [
        //'id',
        'name',
        'normalizeName'
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
        'normalizeName'
    ];

    protected $rules = [
        'name' => 'required'
    ];

    public function users()
    {
        return $this->hasMany(User::class);
    }
}
