<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/',
    function () {
        $system_return = [];
        exec('cd .. && php artisan route:list',$system_return);
        return print_r($system_return,true);
    }
);

Route::get('/produtos','MeuControlador@produtos');
Route::get('/idade','MeuControlador@getIdade');
Route::get('/nome','MeuControlador@getNome');
Route::get('/multiplicar/{numeroX}/{numeroY}','MeuControlador@multiplicar')->where('numeroX','[0-9]+')->where('numeroY','[0-9]+');


Route::resource('cliente','ControladorCliente');
