<h1>Clientes</h1>
<ol>
    @foreach($clientes as $cliente)
        <li>{{ $cliente['dados']['nome']}} | <a href="{{route('cliente.show',$cliente['id'])}}">Link</a> </li>
    @endforeach
</ol>
