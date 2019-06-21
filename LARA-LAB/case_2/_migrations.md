# MIGRATIONS

## ARTISAN 

- **php artisan make:migration criar_produtos --create=produtos** new
- **php artisan make:migration adcionar_categoria_id_em_produto --table=categoria** edit
- **php artisan migrate:rollback**
- **php artisan migrate:refresh**


## FILE




## CODE

- **$table->bigInteger('fk_id')->unsigned();**
- **$table->foreign('fk_id')->references('id')->on('table');**
- **$table->dropForeign(['fk_id']);**
- **$table->dropColumn(['fk_id']);**

<hr>
