# [Review Passport+OAuth](https://www.youtube.com/watch?v=zVRz9tUxX4E)

**Auth Sccafold Laravel 8**
```
composer require laravel/ui && php artisan ui vue --auth && npm install && npm run dev
```

**Passport Stuff**
```
composer require laravel/passport 
php artisan migrate
php artisan passport:install


UserModel >> use Laravel\Passport\HasApiTokens, use HasApiTokens

AuthServiceProvider >> boot() >> use Laravel\Passport\Passport; Passport::routes()

config/auth >> api/driver >> passport

php artisan passport:client

php artisan make:model Passport/Client
```
