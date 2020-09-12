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
    'client_id' => env('CLIENT_ID'),
    'redirect_url' => env('REDIRECT_URL'),
    'response_type' => 'code',
    'scope' => '',
    'state' => $state
]);
$url = env('API_URL').'oauth/authorize?';
return redirect($url.$query);

})->name('prepare.login');

Route::get('/callback',function(Request $request){
    echo "LOGADO <br>";

    $url = env('API_URL').'oauth/token';
    $data = [
        'grant_type' => 'authorization_code',
        'client_id' => env('CLIENT_ID'),
        'client_secret' => env('CLIENT_SECRET'),
        'redirect_url' => env('REDIRECT_URL'),
        'code' => $request->code
    ];
    $response = Http::post($url,$data);

    dd($response->json());

});
