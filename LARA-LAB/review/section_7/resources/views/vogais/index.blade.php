@extends('layouts.principal')
@section('titulo','Vogais')
@section('conteudo')
<h1>Vogais</h1>
@php
    $vogais = ['a','e','i','o','u'];
@endphp
@foreach ($vogais as $vogal)
    <p>
        {{$vogal}} | Index {{$loop->index}} | Count {{$loop->count}} | Iteration {{$loop->iteration}}  @if($loop->first) | First @endif  @if($loop->last) | Last @endif
    </p>
@endforeach
@endsection
