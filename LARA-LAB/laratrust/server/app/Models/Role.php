<?php

namespace App\Models;

use Laratrust\Models\LaratrustRole;

class Role extends LaratrustRole
{
    public $guarded = [];
    protected $fillable = ['name','display_name','description'];
    //Role::create(['name'=>'sudo','display_name'=>'Super Usuario','description' => 'Super Usuario']);
    //Role::create(['name'=>'admin','display_name'=>'Tenant Admin','description' => 'Tenant Admin']);
    //Role::create(['name'=>'user','display_name'=>'Usuario Comum','description' => 'Usuario']);

    // $sudo = Role::whereName('sudo')->first();
    // $edit_user = Permission::whereName('edit-user')->first();
    // ...
    // $sudo->attachPermissions([$edit_user,$create_user,$delete_user,$view_user,$role_user]);
    // $sudo->detachPermissions([$edit_user,$create_user,$delete_user,$view_user,$role_user]);



}
