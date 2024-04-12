<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\EmployerController;
use App\Http\Controllers\FieldController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Models\Employer;
use App\Models\Field;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });


// Route::group(['middleware' => 'jwt.auth'], function () {
//     Route::get('logout', 'App\Http\Controllers\AuthController@logout');
//     Route::get('user', 'App\Http\Controllers\AuthController@user');
// });

// Route::group(['middleware' => 'api'], function () {
//     Route::post('login', 'App\Http\Controllers\AuthController@login');
// });

Route::post('login', [AuthController::class, "login"]);
Route::post('register', [AuthController::class, "register"]);
Route::get('check', [AuthController::class, "checkToken"]);
Route::get('logout', [AuthController::class, "logout"]);
Route::put('/change-email', [UserController::class, "delete"]);

Route::group(['prefix' => 'roles'], function () {
    Route::get('/', [RoleController::class, "get"]);
    Route::get('/{id}', [RoleController::class, "show"]);
    Route::post('/', [RoleController::class, "upload"]);
    Route::put('/{id}', [RoleController::class, "edit"]);
    Route::delete('/{id}', [RoleController::class, "delete"]);
});


Route::group(['prefix' => 'users'], function () {
    Route::get('/', [UserController::class, "get"]);
    Route::get('/{id}', [UserController::class, "show"]);
    Route::post('/', [UserController::class, "upload"]);
    Route::put('/{id}', [UserController::class, "edit"]);
    Route::delete('/{id}', [UserController::class, "delete"]);
    Route::put('/lock/{id}', [UserController::class, "lock"]);

});

Route::group(['prefix' => 'fields'], function () {
    Route::get('/', [FieldController::class, "get"]);
    Route::get('/{id}', [FieldController::class, "show"]);
    Route::post('/', [FieldController::class, "upload"]);
    Route::put('/{id}', [FieldController::class, "edit"]);
    Route::delete('/{id}', [FieldController::class, "delete"]);
});

Route::group(['prefix' => 'employers'], function () {

    Route::get('/', [EmployerController::class, "get"]);
    Route::get('/{id}', [EmployerController::class, "show"]);
    Route::post('/', [EmployerController::class, "upload"]);
    Route::put('/{id}', [EmployerController::class, "edit"]);
    Route::delete('/{id}', [EmployerController::class, "delete"]);
});

Route::group(['prefix' => 'employees'], function () {

    Route::get('/', [EmployeeController::class, "get"]);
    Route::get('/{id}', [EmployeeController::class, "show"]);
    Route::post('/', [EmployeeController::class, "upload"]);
    Route::put('/{id}', [EmployeeController::class, "edit"]);
    Route::delete('/{id}', [EmployeeController::class, "delete"]);
});

