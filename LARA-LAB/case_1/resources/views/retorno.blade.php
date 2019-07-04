@extends("layouts.app")
@section("content")

@php
  //@foreach($retorno as $chave => $prod)
  //{{$chave."|".$prod['id']."|".$prod['nome']  }}<br>
  //@endforeach
@endphp
(I &nbsp;/ C &nbsp;/ R / IT)
<br>
    @foreach($retorno as $chave => $prod)
    <span class="badge badge-secondary">
        ({{$loop->index}} / {{$loop->count}} / {{$loop->remaining}} /
        @if(!$loop->last)&nbsp;@endif
            {{$loop->iteration}}
        @if(!$loop->last)&nbsp;@endif)
    </span>
    {{$chave."|".$prod['id']."|".$prod['nome']}}
        @if($loop->first)
           (PRIMEIRO)
        @elseif($loop->last)
            (ULTIMO)
        @endif
    <br>
    @endforeach
@endsection
