<title>{{$titulo}}</title>
<h1>{{$titulo}}</h1>
@if (count($itens) > 0)
<ol>
    @foreach ($itens as $item)
        <li>{{$item}}</li>
    @endforeach
</ol>
@endif
