<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Call;
use Faker\Generator as Faker;

$factory->define(Call::class, function (Faker $faker) {

    return [
        'user_id' => $faker->randomDigitNotNull,
        'client_name' => $faker->word,
        'type' => $faker->word,
        'description' => $faker->text,
        'deleted_at' => $faker->date('Y-m-d H:i:s'),
        'created_at' => $faker->date('Y-m-d H:i:s'),
        'updated_at' => $faker->date('Y-m-d H:i:s')
    ];
});
