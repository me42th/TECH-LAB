<?php
include_once('_where.php');


Route::get('/', function () {
    return view('welcome');
});


Route::get('novascategorias',function(){
    DB::table('categorias')->insert(
        ['nome' => 'crystal'],
        ['nome' => 'greve'],
        ['nome' => 'fome']
    );
    echo DB::table('categorias')->insertGetId(
        ['nome' => 'carro']
    );
});
