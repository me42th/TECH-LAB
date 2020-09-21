<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Response;
use \App\Http\Controllers\ProductsController;
use \App\Http\Controllers\UserController;

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

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('test',function(Request $request){
    dd($request->headers->all());
    $response = new Response(json_encode(['msg' => 'Api']));
    $response->header('Content-Type','application/json');
    $response->header('David','Meth');
    return $response;
});

Route::resource('users',UserController::class);

Route::resource('products', ProductsController::class);

