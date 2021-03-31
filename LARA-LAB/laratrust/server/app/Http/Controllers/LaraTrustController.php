<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Role;

class LaraTrustController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $dummy_roles = \DB::table('roles')->leftjoin(
            'permission_role',
            'permission_role.role_id',
            'roles.id'
        )->leftjoin(
            'permissions',
            'permissions.id',
            'permission_role.permission_id')->select([
            'roles.name as role_name',
            'roles.display_name as role_display_name',
            'roles.description as role_description',
            'permissions.name as permission_name',
            'permissions.display_name as permission_display_name',
            'permissions.description as permission_description'
        ])->get();

        $data = $dummy_roles->unique('role_name')->map(
            function($item){
                $role = new \stdClass;
                $role->role_name = $item->role_name;
                $role->role_display_name = $item->role_display_name;
                $role->role_description = $item->role_description;
                return $role;
            }
        );

        $data->transform(function($role) use ($dummy_roles){
            $role_data = $dummy_roles->where('role_name',$role->role_name);
            $role->permissions = $role_data->map(function($dummy_permission){
                $permission = new \stdClass;
                $permission->permission_name = $dummy_permission->permission_name;
                $permission->permission_display_name = $dummy_permission->permission_display_name;
                $permission->permission_description = $dummy_permission->permission_description;
                return $permission;
            })->filter(function($permission){
                return !is_null($permission->permission_name);
            });
            $role->permissions = array_values($role->permissions->toArray());
            return $role;
        });

        return array_values($data->toArray());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
