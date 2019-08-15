<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Texto extends Model
{
    protected $table = 'texto';
    protected $primaryKey = 'idtexto';

    public function autor()
    {
        return $this->belongsTo('App\Autor', 'idautor', 'idautor');
    }
}
