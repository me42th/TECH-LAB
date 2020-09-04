<h3>Novo Cliente</h3>
<form action="{{route('client.store')}}" method="post">
    @csrf
    <input type="text" name="nome" >
    <input type="submit" value="Salvar">
</form>
