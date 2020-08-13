<h1>{{$titulo}}</h1>
<h3><a href="{{route('cliente.create')}}">NOVO</a></h3>
<ol>
    @foreach($clientes as $cliente)
        <li>
            {{ $cliente['dados']['nome']}}
             <form action="{{route('cliente.destroy',$cliente['id'])}}" method="post">
             <a href="{{route('cliente.show',$cliente['id'])}}">Show</a>
            | <a href="{{route('cliente.edit',$cliente['id'])}}">Edit</a>
                @csrf
                @method('delete')
            |    <input type="submit" value="Deletar">
              </form>
        </li>
    @endforeach
</ol>
