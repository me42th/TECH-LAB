<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use \App\Models\User;
use \App\Http\Resources\UserCollection;
use \App\Http\Resources\UserResource;
use \App\Http\Requests\UserStoreRequest;
use \App\Http\Controllers\Controller;
class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $users = User::paginate(10);
        return new UserCollection($users);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(UserStoreRequest $request)
    {
        try{
            $user_data = $request->except('password');
            $user_data['password'] = bcrypt($request->password);
            $user = User::create($user_data);
        } catch(\Exception $ex){
            return response()->json(['error'=>'error'],401);
        }
        return new UserResource($user);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try{
            $user = User::findOrFail($id);
        } catch(\Exception $ex){

        }
        return new UserResource($user);
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
        try{
            $user = User::findOrFail($id);
        }catch(\Exception $ex){
            return response()->json(['error'=>'error'],401);
        }
        $user_data = $request->all();
        if(isset($user_data['password'])){
            $user_data['password'] = bcrypt($user_data['password']);
        }
        $user->fill($user_all);
        $user->save();
        return new UserResource($user);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try{
            User::destroy($id);
           // $user->delete();
        }catch(\Exception $ex){
            return response()->json(['error' => 'error'],401);
        }
        return response()->json(['del'=>'del']);
    }
}
