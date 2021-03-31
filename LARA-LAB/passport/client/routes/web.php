<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/prepare', function () {
    $query = http_build_query([
        'client_id'=>env('Client_ID'),
        'redirect_url'=>env('Redirect_URL'),
        'response_type'=>'code',
        'scope'=>''
    ]);
    return redirect("http://localhost:8000/oauth/authorize?$query");
})->name('prepare.login');

Route::get('/callback',function(Request $request){
    $response = Http::post(env('Api_URL').'oauth/token',[
        'grant_type'=>'authorization_code',
        'client_id'=>env('Client_ID'),
        'client_secret'=>env('Client_Secret'),
        'redirect_url'=>env('Redirect_URL'),
        'code'=>$request->code
    ]);
    dd($response->json());
});

Route::get('/password',function(){
    $response = Http::post(env('Api_URL').'oauth/token',[
        'grant_type'=>'password',
        'client_id'=>4,
        'client_secret'=>'TlQ1AQEDCnioF7eM4uLVL8o7jsCrhb7YFISBx3KD',
        'username'=>'l@l.l',
        'password'=>'123123123',
        'scope' => ''
    ]);
    dd($response->json());
});

Route::get('/client',function(){
    $response = Http::post(env('Api_URL').'oauth/token',[
        'grant_type'=>'client_credentials',
        'client_id'=>5,
        'client_secret'=>'dnifeTwdBe0GZyxR7HVbIHW3pdIzUwo0lERUbPBL',
        'scope' => ''
    ]);
    dd($response->json());
});
