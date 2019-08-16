<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Veiculo;
use Faker\Generator as Faker;

$factory->define(Veiculo::class, function (Faker $faker) {

    return [
        'id' => $faker->word,
        'codigo' => $faker->word,
        'placa' => $faker->word,
        'capacidade' => $faker->randomDigitNotNull,
        'descricao' => $faker->word,
        'ano' => $faker->word,
        'modelo' => $faker->word,
        'conservacao' => $faker->word,
        'chassi' => $faker->word,
        'prefixo' => $faker->word,
        'id_bas_veiculo_tipo' => $faker->word,
        'revisao_preventiva' => $faker->word,
        'pneu_estado' => $faker->word,
        'sit_atual_funcionamento' => $faker->word,
        'insp_ccv' => $faker->word,
        'hor_km' => $faker->word,
        'local' => $faker->word,
        'licenciamento' => $faker->word,
        'tag_smec' => $faker->word,
        'marca' => $faker->word,
        'tipo' => $faker->word,
        'cor' => $faker->word,
        'motor' => $faker->word,
        'renavam' => $faker->word,
        'combustivel' => $faker->word,
        'empresa' => $faker->word,
        'tacografo' => $faker->word,
        'tipo_propriedade' => $faker->word,
        'observacao' => $faker->text,
        'quantidade_em_pe' => $faker->word,
        'quantidade_sentado' => $faker->word
    ];
});
