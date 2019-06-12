# VIEWS

## FILES

- **package.json** config npm
- **resources/js/app.js** config ??
- **app/Providers/AppServiceProvider.php** function boot registro componentes

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
- **@slot('name') <br> @endslot** args para componente
- **<div>{{$titulo}}</div>** inserção args componente
- **@slot('type','danger')** inserção args componente
- **@alert(['type' => 'danger','titulo' => 'Erro Fatal'])** tag personalizada function boot
- **@if(condition) @ifelse(condition) @else @endif** autoexplicativo 
- **@empty($var) @endempty** autoexplicativo 
- **@hasSection('section') ... @endif** so imprime uma zona se for passada uma section
- **@switch($var) @case(1) @break @default @endswitch** autoexplicativo

## CODE

- **return view("MinhaView")->with('nome',$nome)->with('sobrenome',$sobrenome);**
- **$args = ["arg" => $var]; return view("view", $args);**
- **return view("MinhaView", compact('nome','sobrenome'));**
- **public function boot()   {  Blade::component('components.alert','alert'); }** 

<hr>
