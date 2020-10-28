<?php

namespace App\Models\Passport;


use Laravel\Passport\Client as BaseClient;

class Client extends BaseClient
{
    public function skipAuthorization(){
        return false;
    }
}
