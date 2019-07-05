<?php
include_once('_where.php');


Route::get('/', function () {
    return view('welcome');
});


Route::get('novas',function(){
    DB::table('categorias')->insert(
        ['nome' => 'crystal'],
        ['nome' => 'greve'],
        ['nome' => 'fome']
    );
    echo DB::table('categorias')->insertGetId(
        ['nome' => 'carro']
    );
});

Route::get('update', function(){
    $cats = DB::table('categorias')->where('id','1')->first();
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->where('id','1')->update(['nome' => 'Roupas Infantis']);
    print_r($cats);
    echo "<hr>";
    $cats = DB::table('categorias')->where('id','1')->first();
    print_r($cats);
    echo "<hr>";

});

Route::get('del',function(){
   $cats = DB::table('categorias')->get();
   print_r($cats);
   echo '<hr>';
   DB::table('categorias')->whereBetween('id',['1','9'])->delete();
   $cats = DB::table('categorias')->get();
   print_r($cats);
   echo '<hr>';
});
