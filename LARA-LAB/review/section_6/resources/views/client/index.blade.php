<sub><a href="{{route('client.create')}}">Novo</a></sub>
<ol>
    @foreach ($clients as $client)
<li>|<a href="{{route('client.edit',$client['id'])}}">EDITAR</a>|
    <a href="{{route('client.show',$client['id'])}}"> {{$client['nome']}} </a>
    <form action="{{route('client.destroy',$client['id'])}}" method="post">
        @csrf
        @method('delete')
        <input type="submit" value="Apagar">
    </form> _________ </li>
    @endforeach
</ol>
