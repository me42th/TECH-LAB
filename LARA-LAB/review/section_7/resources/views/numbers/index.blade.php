@extends('layouts.principal')
@section('titulo','Numbers')
@section('conteudo')
<h1>Numeros</h1>
@for($i = 0 ; $i <= 50; $i++)
    {{$i}}
@endfor
<hr>
@component('components.alert')

@endcomponent
@endsection
