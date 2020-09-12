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

Route::get('/prepare-login',function(){
$state = Str::random(40);

$query = http_build_query([
    'client_id' => env('CLIENT_ID_AUTH_CODE'),
    'redirect_url' => env('REDIRECT_URL_AUTH_CODE'),
    'response_type' => 'code',
    'scope' => '',
    'state' => $state
]);
$url = env('API_URL').'oauth/authorize?';
return redirect($url.$query);

})->name('prepare.login');

Route::get('/callback',function(Request $request){

    $url = env('API_URL').'oauth/token';
    $data = [
        'grant_type' => 'authorization_code',
        'client_id' => env('CLIENT_ID_AUTH_CODE'),
        'client_secret' => env('CLIENT_SECRET_AUTH_CODE'),
        'redirect_url' => env('REDIRECT_URL'),
        'code' => $request->code
    ];
    $response = Http::post($url,$data);

    dd($response->json());

});

Route::get('grant-password',function(){
    $url = env('API_URL').'oauth/token';
    $data = [
        'grant_type' => 'password',
        'client_id' => env('CLIENT_ID_PASSWORD'),
        'client_secret' => env('CLIENT_SECRET_PASSWORD'),
        'username' => 'd@d.d',
        'password' => '123123123',
        'scope' => ''
    ];
    $response = Http::post($url,$data);
    dd($response->json());
})->name('password');
