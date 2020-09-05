<sub><a href="{{route('client.create')}}">Novo</a></sub>
<ol>
    @foreach ($clients as $client)
<li><a href="{{route('client.show',$client['id'])}}"> {{$client['nome']}} </a></li>
    @endforeach
</ol>
