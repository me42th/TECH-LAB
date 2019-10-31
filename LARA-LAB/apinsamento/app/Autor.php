<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Autor extends Model
{
    protected $table = "autor";
    protected $primaryKey = "idautor";

    public function texto(){
        return $this->hasMany('App\Texto', 'idautor', 'idautor');
    }

}
