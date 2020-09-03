# INSTALAÇÃO

```
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');
sudo chmod +x composer.phar
sudo mv composer.phar /usr/local/bin/composer
```

{
  "name": "laravel/laravel",
  "description": "The Laravel Framework.",
  "keywords": [
    "framework",
    "laravel"
  ],
  "license": "MIT",
  "type": "project",
  "require": {
    "php": "^7.1.0",
    "adldap2/adldap2-laravel": "3.0.4",
    "anchu/ftp": "2.0.2",
    "appzcoder/crud-generator": "1.2.3",
    "arcanedev/log-viewer": "4.3.8",
    "artisaninweb/laravel-soap": "0.3.*",
    "barryvdh/laravel-dompdf": "^0.8.2",
    "doctrine/dbal": "2.5.12",
    "filp/whoops": "2.1.9",
    "laravel/framework": "5.4.28",
    "laravel/tinker": "1.0.1",
    "laravelcollective/remote": "5.4",
    "lubusin/laravel-decomposer": "1.2.2",
    "owen-it/laravel-auditing": "3.1.11",
    "phpoffice/phpspreadsheet": "^1.2",
    "symfony/filesystem": "3.3.5",
    "tymon/jwt-auth": "1.0.0-beta.2",
    "vlucas/phpdotenv": "2.4.0"
  },
  "require-dev": {
    "barryvdh/laravel-ide-helper": "^2.4",
    "chumper/zipper": "1.0.1",
    "fzaninotto/faker": "1.6.0",
    "mockery/mockery": "0.9.9",
    "phpunit/phpunit": "6.0.13",
    "squizlabs/php_codesniffer": "2.9.1"
  },
  "autoload": {
    "classmap": [
      "database"
    ],
    "psr-4": {
      "App\\": "app/"
    }
  },
  "autoload-dev": {
    "psr-4": {
        "Tests\\": "tests/"
    }
  },
  "scripts": {
    "post-root-package-install": [
        "php -r \"file_exists('.env') || copy('.env.example', '.env');\""
    ],
    "post-create-project-cmd": [
        "php artisan key:generate"
    ],
    "post-install-cmd": [
        "Illuminate\\Foundation\\ComposerScripts::postInstall",
        "php artisan optimize"
    ],
    "post-update-cmd": [
        "Illuminate\\Foundation\\ComposerScripts::postUpdate",
        "php artisan ide-helper:generate",
        "php artisan ide-helper:meta",
        "php artisan optimize"
    ]
  },
  "config": {
    "preferred-install": "dist",
    "sort-packages": true
  }
}
