<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\User;
use App\Http\Controllers\AppBaseController;

class UserController extends AppBaseController
{
    public function registrar(Request $request){
        $dados = $request->all();
        if(!User::where('email',$dados['email'])->count()){
            $user = new User;
            $user->email = $dados['email'];
            $user->password =  bcrypt($dados['password']);
            $user->name = $dados['name'];
            $user->save();
            return response()->json(['msg'=>'ok','user'=>$user],200);
        }else{
            return response()->json(['msg'=>'Email cadastrado'],400);
        }
    }
}
