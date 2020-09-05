@extends('layouts.principal')
@section('titulo',$titulo)

@section('conteudo')
    <h1>{{$titulo}}</h1>
    <sub><a href="{{route('sete.create')}}">ADD+</a></sub>
    @if (count($itens) > 0)
    <ol>
        @foreach ($itens as $item)
            <li>{{$item}}</li>
        @endforeach
    </ol>
    @endif
@endsection
