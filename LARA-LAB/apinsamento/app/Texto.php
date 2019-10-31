<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Texto extends Model
{
    protected $table = "texto";
    protected $primaryKey = "idtexto";

    public function autor(){
        return $this->belongsTo('App\Autor', 'idautor', 'idautor');
    }

    public static function random(){
        $ids = Texto::all()->pluck('idtexto');
        $valor = $ids[rand(0,count($ids))];
        $texto = Texto::find($valor);
        return $texto;
    }

    public static function tema($tema){
        $ids = Texto::where('texto','like',"%$tema%")->get()->pluck('idtexto');
        if(count($ids) === 0) throw new \Exception();
        $valor = $ids[rand(0,count($ids))];
        $texto = Texto::find($valor);
        return $texto;
    }
}
