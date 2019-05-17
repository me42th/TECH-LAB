# ROUTES

## ARTISAN 

- **php artisan route:list** lista as rotas configuradas

## FILE

- **app/Http/Middleware/VerifyCsfrToken.php** array $exception seta as exceções da seguraça csfr do laravel

## CODE
<code>
- **Route::get('/{n}', function($n){})->where('n','[0-9]+');** valido as info passadas na url
- **Route::match(['get','post'],'/rest/relou', function(){** compartilho uma function com um método
- **Route::any('/rest/relou',function(){** capturo qualquer método com um determinado endpoint
- **Route::get('/optional/{nome?}', function($nome = 'David')** parâmetro nome opcional
- **Route::prefix('app')->group(function(){ Route::get("/",function(){ return ':D';})})** agrupa rotas com prefixos comuns
- **Route::redirect('/david','/app/perfil',301)** redireciona para uma outra rota, exige o código HTTP 3XX
- **Route::view('/relou','hello')** forma abreviada de invocar uma view
- **Route::view('/hello_nome','hello_nome', ['nome' => 'Joao', 'sobrenome' => 'Silva'])** forma abreviada de invocar uma view com argumentos
- **Route::get('/relou_nome/{n}', function($n){ return view('h_n',['nome' => $n])})** invocar view com args na url 
</code>

<hr>
