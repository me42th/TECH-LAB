# MIGRATION

> GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user';

> php artisan make:migration create_products /* old --create=products */

> php artisan migrate:rollback

> select * from migrations;
