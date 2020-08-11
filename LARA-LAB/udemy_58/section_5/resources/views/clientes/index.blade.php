<h1>Clientes</h1>
<h3><a href="{{route('cliente.create')}}">NOVO</a></h3>
<ol>
    @foreach($clientes as $cliente)
        <li>{{ $cliente['dados']['nome']}} | <a href="{{route('cliente.show',$cliente['id'])}}">Link</a> </li>
    @endforeach
</ol>
