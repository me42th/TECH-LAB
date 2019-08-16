<div class="table-responsive">
    <table class="table" id="textos-table">
        <thead>
            <tr>
                <th>Texto</th>
        <th>Idautor</th>
        <th>Pagina</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($textos as $texto)
            <tr>
                <td>{!! $texto->texto !!}</td>
            <td>{!! $texto->idautor !!}</td>
            <td>{!! $texto->pagina !!}</td>
                <td>
                    {!! Form::open(['route' => ['textos.destroy', $texto->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{!! route('textos.show', [$texto->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-eye-open"></i></a>
                        <a href="{!! route('textos.edit', [$texto->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-edit"></i></a>
                        {!! Form::button('<i class="glyphicon glyphicon-trash"></i>', ['type' => 'submit', 'class' => 'btn btn-danger btn-xs', 'onclick' => "return confirm('Are you sure?')"]) !!}
                    </div>
                    {!! Form::close() !!}
                </td>
            </tr>
        @endforeach
        </tbody>
    </table>
</div>
