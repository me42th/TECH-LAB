<?php


use Illuminate\Http\Request;

//include("session_routes.php");
//include("session_ctrl.php");

Route::get('/ola/{nome}/{sobrenome}',function ($nome, $sobrenome){
    return view("MinhaView")->with('nome',$nome)->with('sobrenome',$sobrenome);
});

Route::get('/hello/{nome}/{sobrenome}',function ($nome, $sobrenome){
    $parametros = ["nome" => $nome, "sobrenome" => $sobrenome];
    return view("MinhaView", $parametros);
});

Route::get('/relou/{nome}/{sobrenome}', function($nome, $sobrenome){

    return view("MinhaView", compact('nome','sobrenome'));
});

Route::view('/npm','pag');

Route::get('/produtos','ProdutoControlador@listar');

Route::get('/email/{email}',function($email){
    if (View::exists('email'))
    {
        return view('email',compact('email'));
    }
    return view('error');

});

Route::get('/',function(){

    return view('filho');

});
