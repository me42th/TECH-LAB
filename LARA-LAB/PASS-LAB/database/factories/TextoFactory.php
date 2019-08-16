<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Texto;
use Faker\Generator as Faker;

$factory->define(Texto::class, function (Faker $faker) {

    return [
        'texto' => $faker->text,
        'idautor' => $faker->randomDigitNotNull,
        'pagina' => $faker->randomDigitNotNull
    ];
});
