@extends('layouts.principal')
@section('titulo','Numbers')
@section('conteudo')
<h1>Numeros</h1>
@for($i = 0 ; $i <= 50; $i++)
    {{$i}}
@endfor
<hr>
@component('components.alert',['titulo'=>'Erro Fatal','tipo' => 'info'])
<b>TEXTO A</b>
@endcomponent

@component('components.alert',['titulo'=>'Mensagem Envolvente','tipo' => 'error'])
<b>TEXTO B</b>
@endcomponent

@component('components.alert',['titulo'=>'Olha Ai','tipo' => 'warning'])
<b>TEXTO C</b>
@endcomponent

@component('components.alert',['titulo'=>'Sério isso?','tipo' => 'success'])
<b>TEXTO D</b>
@endcomponent

@endsection
