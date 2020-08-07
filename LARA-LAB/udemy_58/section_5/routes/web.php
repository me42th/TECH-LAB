<?php

use Illuminate\Http\Request;
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

Route::prefix('/app')->group(function(){
    Route::get('/',function(){
        return view('app');
    })->name('app');
    Route::get('/user',function(){
        return view('user');
    })->name('app.user');
    Route::get('/profile',function(){
        return view('profile');
    })->name('app.profile');
});

Route::get('/opcional/{nome}/{sobrenome?}',function($nome,$sobrenome = ''){
    return "Olá $nome $sobrenome ";
});

Route::get('/regra/{nome}/{qtd}',function($nome,$qtd){
    for($cont = 0; $cont <= $qtd; $cont++){
        echo " $nome <br> $cont $qtd \n";
    }
})->where('qtd','[1-9]+')->where('nome','[a-zA-Z]+');

Route::get('/produtos', function() {
    echo "
        <h1>Produtos</h1>
        <ol>
            <li>Notebook</li>
            <li>Impressora</li>
            <li>Mouse</li>
        </ol>
    ";
})->name('meusprodutos');

Route::redirect('products','produtos',301);

Route::get('productos', function(){
    return redirect()->route('meusprodutos');
});

Route::put('req','MeuControlador@index');

Route::delete('req',
    function(Request $request){
        return 'Rellou DEL';
    }
);

Route::patch('req',
    function(Request $request){
        return 'Rellou PATCH';
    }
);

Route::post('req',
    function(Request $request){
        return 'Rellou Pouste';
    }
);

Route::options('req',
    function(Request $request){
        return 'Rellou Options';
    }
);


require_once('resource.php');
