<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class MeuControlador extends Controller
{
    public function index(Request $request){
        return json_encode($request);
    }
}
