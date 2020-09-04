<ol>
    @foreach ($clients as $client)
<li>{{$client['nome']}} <a href="http://localhost:8000/clients/{{$client['id']}}"></a></li>
    @endforeach
</ol>
