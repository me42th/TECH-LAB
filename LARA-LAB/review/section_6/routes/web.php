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

Route::redirect('/','/clients');

Route::get('/produtos','ctrl@produtos');

Route::get('/produto/{nome}/{preco}','ctrl@produto');

Route::resource('client','clientCtrl');
