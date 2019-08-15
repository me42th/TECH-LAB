<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Autor;
use Faker\Generator as Faker;

$factory->define(Autor::class, function (Faker $faker) {

    return [
        'nome' => $faker->word,
        'limite' => $faker->randomDigitNotNull,
        'url' => $faker->word,
        'titulo' => $faker->word
    ];
});
