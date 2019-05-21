<?php


use Illuminate\Http\Request;

//include("session_routes.php");

Route::get('/nome','MyCtrl@getNome');

Route::get('/multiplicar/{n1}/{n2}','MyCtrl@multiplicar');

Route::get('/nome-id/{id}','MyCtrl@getNomeByID')->where('id','[0-2]');
