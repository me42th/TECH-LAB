<h3>Novo Cliente</h3>
<form action="{{route('client.update',$client['id'])}}" method="post">
    @csrf
    @method('PUT')
    <input type="text" name="nome" value="{{$client['nome']}}">

    <input type="submit" value="Salvar">
</form>
