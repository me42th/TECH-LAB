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
    return view('welcome');
});

Route::get('/opcional/{nome}/{sobrenome?}',function($nome,$sobrenome = ''){
    return "Olá $nome $sobrenome ";
});

Route::get('/regra/{nome}/{qtd}',function($nome,$qtd){
    for($cont = 0; $cont <= $qtd; $cont++){
        echo " $nome <br> $cont $qtd \n";
    }
})->where('qtd','[1-9]+')->where('nome','[a-zA-Z]+');
