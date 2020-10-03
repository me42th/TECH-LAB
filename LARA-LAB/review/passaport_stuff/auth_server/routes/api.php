<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Route::middleware('auth:api')->get('/user', function (Request $request) {
Route::middleware('auth:api')->get('/user', function (Request $request) {
    $response = [
                    'type' => 'GET',
                    'user' => $request->user()
                ];
    return $response;
});

Route::middleware('auth:api')->post('/user', function (Request $request) {
    $response = [
                    'type' => 'POST',
                    'user' => $request->user(),
                    'var' => $request->var
                ];
    return $response;
});