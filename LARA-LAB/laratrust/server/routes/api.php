<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
Use App\Http\Controllers\LaraTrustController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:api')->resource('/laratrust',LaraTrustController::class);

Route::middleware('auth:api')->group(function(){
    Route::get('/view-role', [LaraTrustController::class,'index'])->middleware('permission:view-role');

    Route::get('/edit-role', function(){
        return response()->json(['msg' => 'ok'],418);
    })->middleware('permission:edit-role');

    Route::get("/create-user",function(){
        return response()->json(['msg' => 'ok'],418);
    })->middleware('permission:create-user');

    Route::get("/view-user",function(){
        return response()->json(['msg' => 'ok'],418);
    })->middleware('permission:view-user');

    Route::get("/change-role-user",function(){
        return response()->json(['msg' => 'ok'],418);
    })->middleware('permission:change-role-user');

    Route::get("/edit-user",function(){
        return response()->json(['msg' => 'ok'],418);
    })->middleware('permission:edit-user');

    Route::get("/create-role",function(){
        return response()->json(['msg' => 'ok'],418);
    })->middleware('permission:create-role');

    Route::get("/edit-role",function(){
        return response()->json(['msg' => 'ok'],418);
    })->middleware('permission:edit-role');

    Route::middleware('role:sudo')->group(function(){

        Route::get("/delete-role",function(){
            return response()->json(['msg' => 'ok'],418);
        })->middleware('permission:delete-role');

        Route::get("/delete-user",function(){
            return response()->json(['msg' => 'ok'],418);
        })->middleware('permission:delete-user');

    });
});

