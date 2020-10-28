<?php

use Illuminate\Support\Facades\Route;

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

Route::get('/a', function () {
    return \DB::table('actor')
    ->where(
        [
            ['last_name','=','Berry'],
            ['first_name','=','Karl']
        ])->get();
});

Route::get('/b', function () {
    return \DB::table('actor')
    ->where(function($query){
        $query->where('last_name','Berry');
    })->get();
});

// select last_name, count(*) as actor_count
// from actor
// group by last_name
// order by actor_count desc
Route::get('/c',function(){
    return \DB::table('actor')
    ->select(['last_name',\DB::raw('count(*) as actor_count'),\DB::raw('count(*)')])
    ->groupBy('last_name')
    ->orderBy('actor_count','desc')
    ->get();
});

// select country_id, country
// from country
// where country in('Afeghanistan','Bangladesh','China')
// order by country_id desc
Route::get('/d',function(){
    return \DB::table('country')
    ->select(['country_id','country'])
    ->whereIn('country',['Afghanistan','Bangladesh','China'])
    ->get();
});
/*
select film_id, title, special_features, replacement_cost from film
where replacement_cost between 19.99 and 20.99
order by film_id
limit 10
*/
Route::get('/e',function(){
    return \DB::table('film')
    ->select(['film_id', 'title', 'special_features', 'replacement_cost'])
    ->whereBetween('replacement_cost',[19.99,20.99])
    ->orderBy('film_id')
    ->limit(10)
    ->get();
});

Route::get('/f',function(){
    return \DB::table('film')
    ->select(['film_id','title','special_features','replacement_cost'])
    ->whereNotBetween('replacement_cost',[19.99,20.99])
    ->orderBy('film_id')
    ->limit(10)
    ->get();
});

/**
 * select * from film
 * where title = 'African Egg'
 * or title = 'Agent Truman'
 */
Route::get('/g',function(){
    return \DB::table('film')->select(['film_id','title','special_features','replacement_cost'])
    ->where('title','African Egg')
    ->orWhere('title','Agent Truman')
    ->get();
});

/**
 * select s.staff, s.first_name, s.last_name, s.email
 *      addr.address,addr.distrinct,addr.postal_code,
 *      c.city, country.country
 * from staff s
 *  left join address addr
 *      on s.address_id = addr.address_id
 *  left join city c
 *      on c.city_id = addr.city_id
 *  left join country
 *      on country.country_id = c.country_id;
 */
Route::get('/h',function(){
    return \DB::table('staff as s')->select([
            's.staff_id','s.first_name','s.last_name','s.email','addr.address',
            'addr.district','addr.postal_code','c.city','country.country'
        ])->leftJoin('address as addr','s.address_id','=','addr.address_id')
        ->leftJoin('city as c','addr.city_id','=','c.city_id')
        ->leftJoin('country','country.country_id','=','c.country_id')
        ->orderBy('staff_id')
        ->get();
});

/**
 * select film_id, title
 * from film
 * where title like 'K%' or title like 'Q%'
 * and language_id in (
 *      select language_id
 *      from language
 *      where name = 'English'
 * )
 * order by title;
 */
Route::get('/i',function(){
    return \DB::table('film')
        ->select(['film_id','title'])
        ->where('title','LIKE','K%')
        ->orWhere('title','LIKE','Q%')
        ->whereIn('language_id',function($query){
            $query->select('language_id')
            ->from('language')->where('name','English');
        })->orderBy('title')->toSql();
});

/**
 * select film_id, title
 * from film
 * where title like 'K%' or title like 'Q%'
 * and language_id in (
 *      select language_id
 *      from language
 *      where name = 'English'
 * )
 * order by title;
 */
Route::get('/j',function(){
    return \DB::table('film')
        ->select(['film_id','title'])
        ->where('title','LIKE','K%')
        ->orWhere('title','LIKE','Q%')
        ->whereIn('language_id',function($query){
            $query->select('language_id')
            ->from('language')->where('name','English');
        })->orderBy('title')->get();
});

/**
 * select store_details.*, payment_details.*
 *
 * from (
 *      select sto.store_id, city.city, country.country
 *      from store as sto
 *          left join address addr
 *              on sto.address_id = addr.address_id
 *          join city
 *              on addr.city_id = city.city_id
 *          join country
 *              on country.country_id = city.country_id
 * ) as store_details
 * inner join (
 *      select cus.store_id, sum(pay.payment) as sales
 *      from customer as cus
 *          join paument as pay
 *              on cus.customer_id = pay.customer_id
 *      group by cus.store_id
 * ) as payment_details
 * on store_details.store_id = payment_details.store_id
 * order by store_details.store_id
 */
Route::get('/l',function(){
    $store_details = \DB::query()->select(['sto.store_id', 'city.city', 'country.country'])
        ->from('store as sto')
        ->leftJoin('address as addr','sto.address_id','=','addr.address_id')
        ->join('city','addr.city_id','=','city.city_id')
        ->join('country','country.country_id','=','city.country_id');

    $payment_details = \DB::query()->select(['cus.store_id',\DB::raw('sum(pay.amount) as sales')])
        ->from('customer as cus')
        ->join('payment as pay','cus.customer_id','=','pay.customer_id')
        ->groupBy('cus.store_id');

    $results = \DB::query()->select(['store_details.*','payment_details.*'])
        ->fromSub($store_details, 'store_details')
        ->joinSub($payment_details,'payment_details','store_details.store_id','=','payment_details.store_id')
        ->orderBy('store_details.store_id')
        ->get();

    return $results;
});

/**
 * select store_details.*, payment_details.*
 *
 * from (
 *      select sto.store_id, city.city, country.country
 *      from store as sto
 *          left join address addr
 *              on sto.address_id = addr.address_id
 *          join city
 *              on addr.city_id = city.city_id
 *          join country
 *              on country.country_id = city.country_id
 * ) as store_details
 * inner join (
 *      select cus.store_id, sum(pay.payment) as sales
 *      from customer as cus
 *          join paument as pay
 *              on cus.customer_id = pay.customer_id
 *      group by cus.store_id
 * ) as payment_details
 * on store_details.store_id = payment_details.store_id
 * order by store_details.store_id
 */
Route::get('/m',function(){

    $results = \DB::query()->select(['store_details.*','payment_details.*'])
        ->fromSub(function($query){
            $query->select(['sto.store_id', 'city.city', 'country.country'])
                ->from('store as sto')
                ->leftJoin('address as addr','sto.address_id','=','addr.address_id')
                ->join('city','addr.city_id','=','city.city_id')
                ->join('country','country.country_id','=','city.country_id');
        }, 'store_details')
        ->joinSub(function($query){
            $query->select(['cus.store_id',\DB::raw('sum(pay.amount) as sales')])
            ->from('customer as cus')
            ->join('payment as pay','cus.customer_id','=','pay.customer_id')
            ->groupBy('cus.store_id');
        },'payment_details','store_details.store_id','=','payment_details.store_id')
        ->orderBy('store_details.store_id')
        ->get();

    return $results;
});
