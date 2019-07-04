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
    $cats = DB::table('categorias')->where('nome','like','%p%')->get();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->where('id',1)->orWhere('id',2)->get();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->whereBetween('id',[1,2])->get();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->whereNotBetween('id',[1,2])->get();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->whereIn('id',[1,3])->get();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->whereNotIn('id',[1,3,4])->get();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->where([['id',1],['nome','like','R%s']])->get();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->where([['nome','like','%']])->orderBy('nome','desc')->get();
    print_r($cats);
    echo "<hr>";
});
