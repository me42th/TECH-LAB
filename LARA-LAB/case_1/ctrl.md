# CONTROLLERS

## ARTISAN 

- **php artisan make:controller MyCtrl**
- **php artisan make:controller MeuControlador --resource**

## FILE



## CODE

- **return response("TEXTO", 201);**
- **Route::resource('/cliente', 'ClienteController');**
- **curl -X POST -d "nome=David&sobrenome=Meth&_method=PATCH" localhost:8000/cliente/15** put e patch não existem no http, post + arg _method

<hr>
