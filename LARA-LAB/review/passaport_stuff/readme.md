# [Review Passport+OAuth](https://www.youtube.com/watch?v=zVRz9tUxX4E)

**Auth Sccafold Laravel 8**
```
composer require laravel/ui
php artisan ui vue --auth
```

**Passport Stuff**
```
composer require laravel/passport
php artisan passport:install
php artisan migrate

UserModel >> use HasApiTokens

AuthServiceProvider >> boot() >> Passport::routes()

config/auth >> api/driver >> passport

php artisan passport:client
```
