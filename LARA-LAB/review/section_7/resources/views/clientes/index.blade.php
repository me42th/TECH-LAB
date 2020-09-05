<title>{{$titulo}}</title>
<h1>{{$titulo}}</h1>
<ol>

    @forelse ($itens as $item)
        <li>{{$item}}</li>
    @empty
        <li>Vazio</li>
    @endforelse
</ol>
