# ELOQUENT

## ARTISAN 

- **php artisan make:model Categoria -m**

## FILE

## CODE

- **protected $table_name = "categoria"**
- **Model::findOrFail($id);** count() == 0 =>> 404  

## Insert

``` 
Route::get('/inserir/{nome}',function($nome){
    $cat = new Cat;
    $cat->nome = $nome;
    $cat->save();
});
```
<hr>
