<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\EmployerController;
use App\Http\Controllers\FieldController;
use App\Http\Controllers\Recruitment_ArticleController;
use App\Http\Controllers\RecruitmentArticleController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Middleware\RoleMiddLeware;
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
//Route::middleware(RoleMiddLeware::class.':'.implode(',', ['admin','employer']))->get('/', [RoleController::class, "get"]);
Route::post('login', [AuthController::class, "login"]);
Route::post('register', [AuthController::class, "register"]);
Route::get('check', [AuthController::class, "checkToken"]);
Route::get('logout', [AuthController::class, "logout"]);
Route::put('/change-email', [UserController::class, "delete"]);

Route::group(['prefix' => 'roles', 'middleware' => RoleMiddLeware::class.':'.implode(',', ['admin'])], function () {
    Route::get('/', [RoleController::class, "get"]);
    Route::get('/{id}', [RoleController::class, "show"]);
    Route::post('/', [RoleController::class, "upload"]);
    Route::put('/{id}', [RoleController::class, "edit"]);
    Route::delete('/{id}', [RoleController::class, "delete"]);
});



Route::group(['prefix' => 'users', 'middleware' => RoleMiddLeware::class.':'.implode(',', ['admin'])], function () {
    Route::get('/', [UserController::class, "get"]);
    Route::get('/{id}', [UserController::class, "show"]);
    Route::post('/', [UserController::class, "upload"]);
    Route::put('/{id}', [UserController::class, "edit"]);
    Route::delete('/{id}', [UserController::class, "delete"]);
    Route::put('/lock/{id}', [UserController::class, "lock"]);

});

Route::group(['prefix' => 'fields', 'middleware' => RoleMiddLeware::class.':'.implode(',', ['admin, employee, employer'])], function () {
    Route::get('/', [FieldController::class, "get"]);
    Route::get('/{id}', [FieldController::class, "show"]);
    Route::post('/', [FieldController::class, "upload"]);
    Route::put('/{id}', [FieldController::class, "edit"]);
    Route::delete('/{id}', [FieldController::class, "delete"]);
});

Route::group(['prefix' => 'employers', 'middleware' => RoleMiddLeware::class.':'.implode(',', ['admin, employer'])], function () {
    Route::get('/me', [EmployerController::class, "me"]);
    Route::get('/', [EmployerController::class, "get"]);
    Route::get('/{id}', [EmployerController::class, "show"]);
    Route::post('/', [EmployerController::class, "upload"]);
    Route::put('/{id}', [EmployerController::class, "edit"]);
    Route::put('/edit', [EmployerController::class, "edit_1"]);
    Route::delete('/{id}', [EmployerController::class, "delete"]);
});

Route::group(['prefix' => 'employees', 'middleware' => RoleMiddLeware::class.':'.implode(',', ['admin, employee'])], function () {
    Route::get('/me', [EmployeeController::class, "me"]);
    Route::get('/', [EmployeeController::class, "get"]);
    Route::get('/{id}', [EmployeeController::class, "show"]);
    Route::post('/', [EmployeeController::class, "upload"]);

    Route::put('/{id}', [EmployeeController::class, "edit"]);
    Route::put('/edit', [EmployeeController::class, "edit_1"]);
    Route::delete('/{id}', [EmployeeController::class, "delete"]);
});


Route::group(['prefix' => 'ra', 'middleware' => RoleMiddLeware::class.':'.implode(',', ['admin, employer, employee'])], function () {
    Route::get('/public/all', [RecruitmentArticleController::class, "getPublicAll"]);
    Route::post('/apply', [RecruitmentArticleController::class, "raApply"]);
    Route::get('/', [RecruitmentArticleController::class, "get"]);
    Route::get('/{id}', [RecruitmentArticleController::class, "show"]);
    Route::post('/', [RecruitmentArticleController::class, "upload"]);
    Route::put('/{id}', [RecruitmentArticleController::class, "edit"]);
    Route::delete('/{id}', [RecruitmentArticleController::class, "delete"]);
});

