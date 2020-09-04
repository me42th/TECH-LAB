<sub><a href="{{route('client.create')}}">Novo</a></sub>
<ol>
    @foreach ($clients as $client)
<li>{{$client['nome']}} <a href="http://localhost:8000/client/{{$client['id']}}"></a></li>
    @endforeach
</ol>
