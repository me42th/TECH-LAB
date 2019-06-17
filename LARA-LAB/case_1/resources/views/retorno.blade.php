@extends("layouts.app")
@section("content")

    @foreach($retorno as $chave => $prod)
    {{$chave."|".$prod['id']."|".$prod['nome']  }}<br>
    @endforeach
@endsection
