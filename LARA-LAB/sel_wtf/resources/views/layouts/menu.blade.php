@if(\App\Models\User::authUser()->acl_lvl >= 1 )
<li class="{{ Request::is('users*') ? 'active' : '' }}">
    <a href="{!! route('users.index') !!}"><i class="fa fa-edit"></i><span>Users</span></a>
</li>
@endif
<li class="{{ Request::is('calls*') ? 'active' : '' }}">
    <a href="{!! route('calls.index') !!}"><i class="fa fa-edit"></i><span>Calls</span></a>
</li>

