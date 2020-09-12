<?php

namespace App\Models\Passaport;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Passport\Client as BaseClient;

class Client extends BaseClient
{
    use HasFactory;
    public function skipsAuthorization(){
        return true;
    }
}
