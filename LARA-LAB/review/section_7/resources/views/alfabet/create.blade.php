@extends('layouts.principal')
@section('conteudo')
<form action="{{route('sete.store')}}" method="post">
@csrf
<input type="text" name="letter" id="">
<input type="submit" value="GO">
</form>
@endsection
