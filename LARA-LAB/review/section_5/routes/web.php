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


Route::get(
    '/ola/{nome}/{sobrenome?}',
    function ($nome, $sobrenome = '') {
        return "Olá $nome $sobrenome seja bem vindo!";
    }
);

Route::get(
    '/regra/{palavra}/{numero}',
    function ($palavra, $numero) {
        for ($cont = 0; $cont < $numero; $cont++) {
            echo $palavra;
            echo "<br>";
        }
    }
)->where('palavra', '[A-Za-z]+')->where('numero', '[0-9]+');

Route::prefix('/agrupamento')->group(
    function(){
        Route::get('/',
            function(){
                return view('root');
            }
        )->name('agrupamento');

        Route::get('/user',
            function(){
                return view('user');
            }
        )->name('agrupamento.user');

        Route::get('/profile',
            function(){
                return view('profile');
            }
        )->name('agrupamento.profile');

        Route::get('/{valor}',
            function($valor){
                return "Não implementado";
            }
        );
    }

);

Route::get('/destiny', function() {
    echo "
        <h1>Produtos</h1>
        <ol>
            <li>Notebook</li>
            <li>Impressora</li>
            <li>Mouse</li>
        </ol>
    ";
})->name('target');

Route::redirect('/redirect','destiny','301');

Route::get('/redirect2',
    function(){
        return redirect()->route('target');
    }
);
