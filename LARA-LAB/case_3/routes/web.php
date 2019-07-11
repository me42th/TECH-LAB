<?php

use App\Cat;

Route::get('/', function () {
    $cats = Cat::all();
    foreach($cats as $cat){
        echo $cat->nome."\n";
    }
});

Route::get('/inserir/{nome}',function($nome){
    $cat = new Cat;
    $cat->nome = $nome;
    $cat->save();
    return redirect('/');
});
