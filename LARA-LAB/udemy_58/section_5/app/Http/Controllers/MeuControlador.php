<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class MeuControlador extends Controller
{
    public function index(Request $request){
        return json_encode($request);
    }

    public function produtos(){
        echo "
        <h1>Produtos</h1>
        <ol>
            <li>Notebook</li>
            <li>Impressora</li>
            <li>Mouse</li>
        </ol>
    ";
    }

    public function getIdade(){
        return '30 anos';
    }

    public function getNome(){
        return 'Jose da Silva';
    }

    public function multiplicar($numeroX, $numeroY){
        return $numeroX * $numeroY;
    }
}
