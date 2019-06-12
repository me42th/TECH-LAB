<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ProdutoControlador extends Controller
{
    public function listar(){
        $produtos  = $this->empty();
        return view('produtos',compact('produtos'));
    }

    public function many(){
       $retorno = [
            "PRODUTO A",
            "PRODUTO B",
            "PRODUTO C",
            "PRODUTO D",
            "PRODUTO E",
            "PRODUTO F",
            "PRODUTO G",
            "PRODUTO H",
            "PRODUTO I",
            "PRODUTO J"

        ];

        return $retorno;

    }

    public function one(){

        $retorno = [
            "PRODUTO A"

        ];

        return $retorno;

    }

    public function empty(){
        $retorno = [
        ];

        return $retorno;
    }

    public function secao($palavra){
        return view('section', compact('palavra'));
    }
    public function switch_case($palavra){
        return view('switch_case',compact('palavra'));
    }
}
