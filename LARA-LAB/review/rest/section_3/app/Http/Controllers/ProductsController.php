<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Product;
use App\Http\Resources\ProductResource;
use App\Http\Resources\ProductCollection;

class ProductsController extends Controller
{

    private $product;
    public function __construct(Product $product){
            $this->product = $product;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $products = $this->product;

        if($request->has('conditions')){
            $conditions = explode(';',$request->get('conditions'));
            foreach($conditions as $condition){
                $condition = explode(':',$condition);
                if(count($condition) == 2){
                    $products = $products->where($condition[0],$condition[1]);
                } else if (count($condition) == 3){
                    $products = $products->where($condition[0],$condition[1],$condition[2]);
                }
            }
        }

        if($request->has('fields')){
            $fields = $request->get('fields');
            $products = $products->selectRaw($fields);
        }

        return new ProductCollection($products->paginate(10));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        return new ProductResource(
            Product::firstOrCreate($request->all())
        );

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
        return new ProductResource($product);
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

        return new ProductResource($product);
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
        return new ProductResource($product);
    }
}
