<?php

use Illuminate\Support\Facades\DB;

Route::get('/', function () {
    return view('welcome');
});

Route::get("categorias",function(){
    $cats = DB::table('categorias')->get();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->pluck('nome');
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->where('id',1)->first();
    print_r($cats);
    echo "<hr>";

});
