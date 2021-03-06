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

Route::post('/cadastro','UserController@registrar');

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('v1')->group(function () {
    Route::resource('autors', 'AutorAPIController');
    Route::resource('textos', 'TextoController');
    Route::get('texto/{id}','TextoController@shower');
});

Route::group(['middleware' =>['auth:api']],function(){
    Route::prefix('v1')->group(function () {

    });


    Route::any('/', function () {
        return "logado \n";
    });

});






