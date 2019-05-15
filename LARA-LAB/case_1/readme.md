# Routes

## ARTISAN 

- **php artisan route:list** lista as rotas configuradas

## CODE

- **Route::get('/{n}', function($n){})->where('n','[0-9]+');** valido as info passadas na url
- **Route::get('/optional/{nome?}', function($nome = 'David')** parâmetro nome opcional
