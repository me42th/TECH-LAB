<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use \App\Texto;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public function random(){
        $texto = Texto::random();

        return response()->json([
            'code' => '201',
            'texto' => $texto->texto,
            'autor' => $texto->autor->nome
        ]);
    }

    public function tema($tema){
    try{
        if(strlen ($tema) > 127) throw new \Exception();

        $texto = Texto::tema($tema);

        return response()->json([
            'code' => '201',
            'texto' => $texto->texto,
            'autor' => $texto->autor->nome
        ]);

    }catch(\Exception $ex){
        return response()->json([
            'code' => '404'
        ]);
    }
  }
}
