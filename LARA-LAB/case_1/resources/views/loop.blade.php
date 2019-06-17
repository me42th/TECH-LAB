@extends('layouts.app')

@section('content')
    @for($i = 0; $i < $n; $i++)
    {{$i}}<br>
    @endfor
@endsection
