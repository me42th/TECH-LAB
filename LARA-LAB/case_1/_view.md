# ROUTES

## ARTISAN 



## BLADE

- **@yield("content")** |SUPER|especifico zonas
- **@extends('layouts.app')** |SUB|herdo esqueleto
- **@section('content') <h1> conteudo </h1> @endsection** |SUB|insiro na zona
- **@section('title','titulo')** |SUB| insiro na zona
- **@section("family-content") <h1> conteudo PAI</h1> @show** |SUPER| compartilho uma zona
- **@section('family-content') @parent <h1>FILHO</h1> @endsection** |SUB| customizo uma zona e invoco super

## CODE

- **return view("MinhaView")->with('nome',$nome)->with('sobrenome',$sobrenome);**
- **$args = ["arg" => $var]; return view("view", $args);**
- **return view("MinhaView", compact('nome','sobrenome'));**

<hr>
