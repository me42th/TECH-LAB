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
<div>
    <ul>
        <li><a href="" class="warning">warning</a></li>
        <li><a href="" class="error">error</a></li>
        <li><a href="" class="success">success</a></li>
        <li><a href="" class="info">info</a></li>
    </ul>
</div>
@php
    $variavel = random_int(0,10);
@endphp
@switch($variavel)
    @case(0)
        Zero
    @break
    @case(1)
        Um
    @break
    @case(2)
        Dois
    @break
    @case(3)
        Tres
    @break
    @case(4)
        Quatro
    @break
    @case(5)
        Cinco
    @break
    @case(6)
        Seis
    @break
    @case(7)
        Sete
    @break
    @case(8)
        Oito
    @break
    @case(9)
        Nove
    @break
    @case(10)
        Dez
    @break
@endswitch
@endsection
