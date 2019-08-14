<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::post('/',function(){
    return "
    +----+------------------------------------------+--------------------------------+
    | id | secret                                   | redirect                       |
    +----+---------+--------------------------------+--------------------------------+
    |  1 | hQEQ4hvJCA5PPLGCyRUomUunSVZAm5pKg1fPgfJJ | http://localhost               |
    |  2 | O1lrLOTxe491wtWmw3HwXeYl118DzA91pUCdqObM | http://localhost               |
    |  3 | oVWqaHwcrCQvczN3HQFtfDNG3jiI5FhWW5yBFDhW | http://localhost/auth/callback |
    +----+---------+--------------------------------+--------------------------------+
    \n";
});

Route::get('/', function () {
    return view('welcome');
});
