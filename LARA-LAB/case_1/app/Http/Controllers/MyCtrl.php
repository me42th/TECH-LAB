<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;

class MyCtrl extends Controller
{
    public function getNome(){
        return "Jose da Silva \n";
    }
    public function multiplicar($n1, $n2){
        return $n1 * $n2." \n";
    }
    public function getNomeByID($id){
        return array('David','Brenda','Murilo')[$id]." \n";
    }
}
