<div class="table-responsive">
    <table class="table" id="calls-table">
        <thead>
            <tr>
                <th>User Id</th>
        <th>Client Name</th>
        <th>Type</th>
        <th>Description</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($calls as $call)
            <tr>
                <td>{!! $call->user_id !!}</td>
            <td>{!! $call->client_name !!}</td>
            <td>{!! $call->type !!}</td>
            <td>{!! $call->description !!}</td>
                <td>
                    {!! Form::open(['route' => ['calls.destroy', $call->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{!! route('calls.show', [$call->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-eye-open"></i></a>
                        <a href="{!! route('calls.edit', [$call->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-edit"></i></a>
                        @if(\App\Models\User::authUser()->acl_lvl >= 1 )
                        {!! Form::button('<i class="glyphicon glyphicon-trash"></i>', ['type' => 'submit', 'class' => 'btn btn-danger btn-xs', 'onclick' => "return confirm('Are you sure?')"]) !!}
                        @endif
                   </div>
                    {!! Form::close() !!}
                </td>
            </tr>
        @endforeach
        </tbody>
    </table>
    {{ $calls->links() }}
</div>
