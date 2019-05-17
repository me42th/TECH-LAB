<?php

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

Route::get('/nome/{nome}/{n}', function($nome,$n){
    // NÃO FUNCIONA POIS TUDO É TRATADO COMO STRING
    if(is_integer($n))
        for($cont = 0;$cont < $n ;$cont++)
            echo "<h1>Ola, $nome $n</h1> \n";
    else
        echo "<h1>erro</h1> \n";
});

Route::get('/regra/{nome}/{n}', function($nome, $n){
    for($i=0;$i <$n;$i++)
        echo "$nome \n";
    system($nome);
})->where('n','[0-9]+')->where('nome','[A-Za-z]+');

Route::get('/optional/{nome?}', function($nome = 'David'){
    echo $nome."\n";
});

Route::redirect('/david','/app/perfil',308);

Route::get('/hello', function(){
    return view('hello');
});

Route::view('/relou','hello');

Route::view('/hello_nome','hello_nome', ['nome' => 'Joao', 'sobrenome' => 'Silva']);

Route::get('/relou_nome/{n}/{sn}', function($n,$sn){
    return view('hello_nome',['nome' => $n,'sobrenome' => $sn]);
});

Route::prefix('app')->group(function(){
    Route::get("/",function(){
        return "Página principal do APP \n";
    });
    Route::get("/perfil",function(){
        return "Seu perfil no APP \n";
    });
    Route::get("/sobre",function(){
        return "Sobre o APP \n";
    });
});

Route::post('/rest/hello', function(){
    return "Hello (POST) \n";
});

Route::delete('/rest/hello', function(){
    return "Hello (DELETE) \n";
});

Route::put('/rest/hello', function(){
    return "Hello (PUT) \n";
});

Route::patch('/rest/hello', function(){
    return "Hello (PATCH) \n";
});

Route::options('/rest/hello', function(){
    return "Hello (OPTIONS) \n";
});


