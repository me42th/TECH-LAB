@extends('layouts.principal')
@section('conteudo')
<h3>Editar Cliente</h3>
<form action="{{route('cliente.update',$cliente['id'])}}" method="POST">
    @csrf
    @method('PUT')
    <input type="text" name="nome" value="{{$cliente['dados']['nome']}}">
    <input type="hidden" name="id" value="{{$cliente['id']}}">
    <input type="submit" value="Salvar">
</form>
@endsection
