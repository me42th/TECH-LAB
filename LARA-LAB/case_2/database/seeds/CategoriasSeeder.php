<?php

use Illuminate\Database\Seeder;

class CategoriasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('categorias')->insert([
            'nome' => 'Roupas'
        ]);
        DB::table('categorias')->insert([
            'nome' => 'Moveis'
        ]);
        DB::table('categorias')->insert([
            'nome' => 'Artesanato'
        ]);
        DB::table('categorias')->insert([
            'nome' => 'Papelaria'
        ]);
    }
}
