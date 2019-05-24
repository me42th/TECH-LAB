# VIEWS

## FILES

- **package.json** config npm
- **resources/js/app.js** config ??


## NPM 

- **npm i** install
- **npm run dev** compila js e css num unico arquivo

## BLADE

- **@yield("content")** |SUPER|especifico zonas
- **@extends('layouts.app')** |SUB|herdo esqueleto
- **@section('content') <h1> conteudo </h1> @endsection** |SUB|insiro na zona
- **@section('title','titulo')** |SUB| insiro na zona
- **@section("family-content") <h1> conteudo PAI</h1> @show** |SUPER| compartilho uma zona
- **@section('family-content') @parent <h1>FILHO</h1> @endsection** |SUB| customizo uma zona e invoco super
- **<link href="{{asset('css/app.css')}}" rel="stylesheet"** css compilado npm
- **<link href="{{URL::to('css/app.css')}}" rel="stylesheet"**css compilado npm
- **<script href="{{asset('js/app.js')}}" type="text/javascript"** js compilado npm
- **<script href="{{URL::to('js/app.js')}}" type="text/javascript"** js compilado npm
- **@component('alert') <b> ERROR </b> @endcomponent** html stripado c/ args
- **<div> {{$slot}} </div>** inserção args componente

## CODE

- **return view("MinhaView")->with('nome',$nome)->with('sobrenome',$sobrenome);**
- **$args = ["arg" => $var]; return view("view", $args);**
- **return view("MinhaView", compact('nome','sobrenome'));**

<hr>
