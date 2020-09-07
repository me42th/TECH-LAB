<?php

use Illuminate\Support\Facades\Route;

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

Route::get('/', function () {
    return redirect()->route('sete.index');
});

Route::resource('sete','ctrl');

Route::view('vogais', 'vogais.index')->name('vogais');
Route::view('numbers','numbers.index')->name('numbers');
Route::view('bootstrap','bootstrap.price')->name('bootstrap.price');
