# MIGRATION

> GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user';

> php artisan make:migration create_products /* old --create=products */

> php artisan migrate:rollback

> select * from migrations;

> php artisan make:migration add_brand_to_products --table=products

> php artisan migrate:refresh

> php artisan migrate:fresh 

> php artisan migrate:status

> php artisan migrate:reset
