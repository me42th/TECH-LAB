<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Product;

class ProductsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response()->json(['status' => 'find','products' => Product::paginate(3)]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $product = Product::firstOrCreate($request->all());
        return response()->json(['status' => 'persisted','product' => $product]);
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
            $product = Product::findOrFail($id);
        }catch(\Exception $ex){
            return response()->json(['status'=>'not found']);
        }
        return response()->json(['status' => 'find','product' => $product]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
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
            $product = Product::findOrFail($id);
        }catch(\Exception $ex){
            return response()->json(['status' => 'not found']);
        }
        $product->fill($request->all());
        $product->save();

        return response()->json(['status'=>'persisted','product'=>$product]);
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
            $product = Product::findOrFail($id);
        }catch(\Exception $ex){
            return response()->json(['status'=>'not found']);
        }
        $product->delete();
        return response()->json(['status' => 'deleted','product' => $product]);
    }
}
