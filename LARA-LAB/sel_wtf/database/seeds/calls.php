<?php

use Illuminate\Database\Seeder;

class calls extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $prefixo = ['Loja', 'Mercado', 'Petshop', 'Magazine','ECommerce','Assistencia','Bar','Restaurante'];
        $sufixo = [' da Ana', 'do Eduardo', ' 9dade', ' Tatu do Bem',' Para Todos',' 20V',' Clacatum',' Pratata', ' Lerolero',' Tiriricratu', ' Murilo e Cia'];

        $users_id = DB::table('users')->where('acl_lvl','0')->pluck('id');
        for($cont = 0; $cont < 1000; $cont++){
            $user_id = $users_id[rand(0,count($users_id))];
            $client_name = 'abc';//$prefixo[rand(0,count($prefixo))].$sufixo[rand(0,count($sufixo))];
            $tipo = rand(0,3);
            $descr = "Mussum Ipsum, cacilds vidis litro abertis. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Aenean aliquam molestie leo, vitae iaculis nisl. Viva Forevis aptent taciti sociosqu ad litora torquent. Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.

            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Leite de capivaris, leite de mula manquis sem cabeça. Posuere libero varius. Nullam a nisl ut ante blandit hendrerit. Aenean sit amet nisi.";

            $mes = rand(1,9);
            $dia = rand(10,28);
            $create = "2020-0$mes-10";
            //dd($create);
            try{
                DB::table('calls')->insert([
                    'user_id' => $user_id,
                    'client_name' => $client_name,
                    'type' => "$tipo",
                    'description' => $descr,
                    'created_at' => $create
                ]);
            }catch(Exception $ex){
                $cont--;
            }
        }
    }
}
