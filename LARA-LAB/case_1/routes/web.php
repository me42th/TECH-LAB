<?php


use Illuminate\Http\Request;

//include("session_routes.php");
//include("session_ctrl.php");

Route::get('/MinhaView',function (){
    return view("MinhaView");
});
