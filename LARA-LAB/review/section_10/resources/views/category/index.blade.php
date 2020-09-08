@extends('layout.app',['current' => 'category'])
@section('body')
    <div class="card border">
        <div class="card-body">
            <h5 class="card-title">
                Cadastro de Categorias
            </h5>

    @if(count($categories) > 0)
    <table class="table table-ordered table-hover">
        <thead>
            <tr>
                <td>Código</td>
                <td>Nome da Categoria</td>
                <td>Ações</td>
            </tr>
        </thead>
        <tbody>
            @foreach($categories as $category)
            <tr>
                <td>{{$category->id}}</td>
                <td>{{$category->name}}</td>
                <td>
                    <form action="{{route('category.destroy',$category->id)}}" method="post">
                        <a href="{{route('category.edit',$category->id)}}" class="btn btn-primary btn-sm">Editar</a>
                        @csrf
                        @method('delete')
                        <input type="submit" value="Deletar" class="btn btn-danger btn-sm">
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
    @endif
    </div>
    <div class="card-footer">
        <a href="{{route('category.create')}}" role="button" class="btn btn-success">Nova Categoria</a>
    </div>
</div>
@endsection
