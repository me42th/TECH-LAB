@extends('layouts.principal')
@section('conteudo')
<h1>Dados</h1>
<h3><b>{{$cliente['id']}}</b> - {{$cliente['dados']['nome']}}</h3>
<a href="{{route('cliente.index')}}">Voltar</a>
@endsection
