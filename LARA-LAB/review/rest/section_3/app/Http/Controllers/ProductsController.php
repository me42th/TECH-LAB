<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Product;
use App\Http\Resources\ProductResource;
use App\Http\Resources\ProductCollection;
use App\Http\Requests\ProductRequest;
use App\Repository\ProductRepository;

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
        $products = (new ProductRepository($this->product,$request))->products;
        return new ProductCollection($products->paginate(10));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(ProductRequest $request)
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
    public function update(ProductRequest $request, $id)
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
