<?php

use Illuminate\Support\Facades\Route;

function teste($variavel){
    echo 'b';
    print_r($variavel);
}

Route::get('/a',function(){
    return \DB::table('actor')->where('last_name','=','Berry')->get();
});

Route::get('/b',function(){
    return \DB::table('actor')->where(function($query){
        $query->where('last_name','Berry');
    })->get();
});

Route::get('/c',function(){
    return \DB::table('actor')
    ->where(function($query){
        $query->where([['last_name','Berry'],['first_name','Karl']]);
    })->get();
});

Route::get('/d',function(){
    return \DB::table('actor')
        ->select(['last_name',\DB::raw('count(*) as actor_count')])
        ->groupBy('last_name')
        ->orderBy('actor_count','desc')->get();
});

Route::get('/f',function(){
    return \DB::table('country')
        ->select('country_id','country')
        ->whereIn('country',['Afghanistan','Bangladesh','China'])
        ->orderBy('country_id','desc')->get();
});

Route::get('/g',function(){
    return \DB::table('film')
        ->select(['film_id','title','special_features','replacement_cost'])
        ->whereBetween('replacement_cost',[19.99,20.99])
        ->limit(10)->get();
});

Route::get('/h',function(){
    return \DB::table('film')
        ->select(['film_id','title','special_features','replacement_cost'])
        ->whereNotBetween('replacement_cost',[19.99,20.99])
        ->limit(10)->get();
});

Route::get('/i',function(){
    return \DB::table('film')
        ->select(['film_id','title','special_features','replacement_cost'])
        ->where('title','African Egg')
        ->orWhere('title','Agent Truman')
        ->get();
});
