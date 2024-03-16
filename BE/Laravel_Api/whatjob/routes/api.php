<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
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


Route::get('roles', [RoleController::class, "get"]);
Route::get('roles/{id}', [RoleController::class, "show"]);
Route::post('roles', [RoleController::class, "upload"]);
Route::put('roles/{id}', [RoleController::class, "edit"]);
Route::delete('roles/{id}', [RoleController::class, "delete"]);

Route::get('users', [UserController::class, "get"]);
Route::get('users/{id}', [UserController::class, "show"]);
Route::post('users', [UserController::class, "upload"]);
Route::put('users/{id}', [UserController::class, "edit"]);
Route::delete('users/{id}', [UserController::class, "delete"]);
