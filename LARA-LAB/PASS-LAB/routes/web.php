<?php

use Illuminate\Http\Request;

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



Route::get('', function(){
    return response()->json(['shell'=>'curl -X POST -H "Accept: application/json" localhost:8000/api'], 200);
});




Auth::routes();

Route::get('/home', 'HomeController@index');
