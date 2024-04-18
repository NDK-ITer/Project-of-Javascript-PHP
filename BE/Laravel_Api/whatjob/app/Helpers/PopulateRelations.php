<?php

namespace App\Helpers;

use App\Models\Role;
use Exception;
use Illuminate\Database\Query\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

class PopulateRelations
{
    public static function populateRelations($query, $relations, $model)
    {
        try {
            print_r($relations);
            if ($relations !== '' && $relations !== null) {

                if ($relations === '*') {
                    $relations = $model->relationships();

                } else {
                    $relations = is_array($relations) ? $relations : explode(',', $relations);
                }

                foreach ($relations as $relation) {
                    if (method_exists($model, $relation)) {
                        $query = $query->with($relation);
                    }
                }
            }
            // else {

            //     $query = $query->get();
            // }
            return $query;
        } catch (Exception $ex) {
            Log::error('Error in populateRelations: ' . $ex->getMessage());
            return $query;
        }
    }
}
