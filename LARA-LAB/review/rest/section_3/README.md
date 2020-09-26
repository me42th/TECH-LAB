


**SHELL**
```
    php artisan make:controller UserController --resource --api
    
    php artisan make:resource ProductResource

    php artisan make:resource ProductCollection
    php artisan make:resource Product --collection

    composer require laravel/legacy-factories
    php artisan make:seeder UsersTableSeeder
    php artisan db:seed

    GET http://localhost:8000/api/products/3
    content-type: application/json
    accept: application/json
    Authorization: Basic c21pdGgubWFyY0BleGFtcGxlLmNvbTpwYXNzd29yZA==

    php artisan make:factory ProductFactory
    php artisan make:seeder ProductSeeder
```
