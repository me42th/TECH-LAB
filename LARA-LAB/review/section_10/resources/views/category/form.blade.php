@extends('layout.app',['current' => 'category'])
@section('body')
<div class="card border">
    <div class="card-body">
        @if(isset($category))
            <form action="{{route('category.update',$category->id)}}" method="post">
            @method('put')
        @else
            <form action="{{route('category.store')}}" method="post">
        @endif
                @csrf
                <div class="form-group">
                    <input type="text" class="form-control" value="@if(isset($category)) {{$category->name}} @endif" name="name" required placeholder="Informe o nome da categoria">
                </div>
                    <input type="submit" value="Salvar" class="btn btn-primary btn-sm">
                    <input type="cancel" value="Cancel" class="btn btn-danger btn-sm">
            </form>
    </div>
</div>
@endsection
