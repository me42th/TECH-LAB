@extends('layout.app',['current' => 'category'])
@section('body')
<div class="card border">
    <div class="card-body">
        <form action="{{route('category.store')}}" method="post">
            @csrf
            <div class="form-group">
                <input type="text" class="form-control" name="name" id="" required placeholder="Informe o nome da categoria">
            </div>
                <input type="submit" value="Salvar" class="btn btn-primary btn-sm">
                <input type="cancel" value="Cancel" class="btn btn-danger btn-sm">
        </form>
    </div>
</div>
@endsection
