# MIGRATIONS

## ARTISAN 

- **php artisan make:migration criar_produtos --create=produtos** new
- **php artisan make:migration adcionar_categoria_id_em_produto --table=categoria** edit 
- **php artisan migrate:rollback**
- **php artisan migrate:refresh**
- **php artisan migrate:fresh** drop 4all with create
- **php artisan migrate:reset** only drop
- **php artisan migrate:status** status of scripts
- **php artisan make:seeder TableSeeder**
- **php artisan db:seed**

## FILE

- **database\seeds\DatabaseSeeder.php**

## CODE

- **$table->bigInteger('fk_id')->unsigned();**
- **$table->foreign('fk_id')->references('id')->on('table');**
- **$table->dropForeign(['fk_id']);**
- **$table->dropColumn(['fk_id']);**
- **DB::table('table')->insert(['meta' => 'Data']);**

<hr>
