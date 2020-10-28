<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Models\Code;
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
// GRANT TYPE CODE
Route::get('prepare-login', function(){
    $state = Str::random(40);

    $query = http_build_query([
        'client_id' => env('A_CLIENT_ID'),
        'redirect_url' => env('A_REDIRECT_URL'),
        'response_type' => 'code',
        'scope' => '',
        'state' => $state
    ]);
    Code::create(['code'=>$state]);
    return redirect(env('API_URL')."/oauth/authorize?$query");
})->name('code');

Route::get('callback',function(Request $request){
    
    $count = Code::where('code',$request->state)->count();
    if($count == 0)
        return json_encode(['msg'=>'erro']);

    $response = Http::post(env('API_URL').'/oauth/token',[
        'grant_type' => 'authorization_code',
        'client_id' => env('A_CLIENT_ID'),
        'client_secret' => env('A_SECRET'),
        'redirect_url' => env('REDIRECT_URL'),
        'code' => $request->code
    ]);
    dd($response->json());
})->name('code.callback');


Route::get('password',function(){
    
    $response = Http::post(env('API_URL').'/oauth/token',[
        'grant_type' => 'password',
        'client_id' => env('B_CLIENT_ID'),
        'client_secret' => env('B_SECRET'),
        'username' => 'david.meth@hotmail.com',
        'password' => '123123123',
        'scope' => ''
    ]);

    dd($response->json());
})->name('password');


Route::get('client',function(){
    
    $response = Http::post(env('API_URL').'/oauth/token',[
        'grant_type' => 'client_credentials',
        'client_id' => env('C_CLIENT_ID'),
        'client_secret' => env('C_SECRET'),
        'scope' => ''
    ]);

    dd($response->json());
})->name('client');
