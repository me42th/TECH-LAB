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

Route::group(['middleware' =>['auth:api']],function(){

    Route::get('/', function () {
        return "logado \n";
    });


    Route::post('/',function(){
        return response()->json(['veiculos'=>'+----+------------------------------------------+--------------------------------+
                                                | id | secret                                   | redirect                       |
                                                +----+---------+--------------------------------+--------------------------------+
                                                |  1 | hQEQ4hvJCA5PPLGCyRUomUunSVZAm5pKg1fPgfJJ | http://localhost               |
                                                |  2 | O1lrLOTxe491wtWmw3HwXeYl118DzA91pUCdqObM | http://localhost               |
                                                |  3 | oVWqaHwcrCQvczN3HQFtfDNG3jiI5FhWW5yBFDhW | http://localhost/auth/callback |
                                                +----+---------+--------------------------------+--------------------------------+'
        ], 200);

    });
});


