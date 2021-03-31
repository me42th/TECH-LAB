<?php

namespace App\Models;

use Laratrust\Models\LaratrustPermission;

class Permission extends LaratrustPermission
{
    public $guarded = [];
    protected $fillable = ['name','display_name','description'];
    //Permission::create(['name' => 'create-user', 'display_name' => 'Criar Usuarios', 'description' => 'Pode criar usuários']);
    //Permission::create(['name' => 'view-user','display_name' => 'Visualizar Usuarios','description' => 'Pode Visualizar usuários']);
    //Permission::create(['name' => 'delete-user','display_name' => 'Deletar Usuarios','description' => 'Pode deletar usuários']);
    //Permission::create(['name' => 'change-role-user','display_name' => 'Add/Rmv Usuarios a Roles','description' => 'Pode modificar o acesso de usuários']);
    //Permission::create(['name' => 'edit-user','display_name' => 'Editar Usuarios','description' => 'Pode editar usuários']);

    //Permission::create(['name' => 'create-role', 'display_name' => 'Criar Regra', 'description' => 'Pode criar regras']);
    //Permission::create(['name' => 'view-role','display_name' => 'Visualizar Regras','description' => 'Pode Visualizar regras']);
    //Permission::create(['name' => 'delete-role','display_name' => 'Deletar Regras','description' => 'Pode deletar regras']);
    //Permission::create(['name' => 'edit-role','display_name' => 'Editar Regras','description' => 'Pode modificar as permissões de uma regra']);

}
