<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ctrl extends Controller
{
    public function produtos(){
        return "
            <h1>Produtos</h1>
            <ol>
                <li><a href='/produto/Notebook/1000,00'>Notebook</a></li>
                <li><a href='/produto/Impressora/700,00'>Impressora</a></li>
                <li><a href='/produto/Mouse/250,00'>Mouse</a></li>
            </ol>
        ";
    }

    public function produto($nome,$preco){
        return "
            <sub><a href='/produtos'>Voltar</a></sub>
            <h1>$nome </h1>
            <ol>
                <li>R$ $preco</li>
            </ol>
        ";
    }
}
