<?php

use Illuminate\Database\Seeder;

class users extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        try{
            DB::table('users')->insert([
            'name' => 'admin',
            'email' => 'a@a.a',
            'acl_lvl' => '2',
            'created_at' => date(now()),
            'password' => bcrypt('123123')
            ]);
        }catch(Exception $ex){
        }
        for($cont = 0; $cont < 200; $cont++){
            $ch = curl_init();
            $acl_lvl =  $cont%2==0?'0':'1';
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json; charset=utf-8") );
            curl_setopt($ch, CURLOPT_URL, "https://randomuser.me/api/?nat=br");
            $result = curl_exec($ch);
            curl_close($ch);
            $result = json_decode($result,true);
            $temp_created_at = explode('T',$result['results'][0]['registered']['date']);
            $C1 = $temp_created_at[0];
            $C2 = explode('Z',$temp_created_at[1])[0];
            $created_at = $C1." ".$C2;
            try{
            DB::table('users')->insert([
                'acl_lvl' => $acl_lvl,
                'name' => ucfirst($result["results"][0]["name"]["first"])." ".ucfirst($result["results"][0]["name"]["last"]),
                'email' => $result["results"][0]["email"],
                'password' => bcrypt('123123'),
                'created_at' => $created_at
            ]);


            }catch(Exception $ex){
                $cont--;

            }
        }

    }
}
