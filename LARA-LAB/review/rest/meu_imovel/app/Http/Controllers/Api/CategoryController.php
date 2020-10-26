<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use \App\Http\Requests\CategoryIndexRequest;
use \App\Http\Requests\CategoryStoreRequest;
use \App\Http\Requests\CategoryShowRequest;
use \App\Http\Requests\CategoryUpdateRequest;
use \App\Http\Requests\CategoryDestroyRequest;
use \App\Models\Category;
use \App\Http\Resources\CategoryCollection;
use \App\Http\Resources\CategoryResource;


class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(CategoryIndexRequest $request)
    {
        $categories = Category::paginate(10);
        return new CategoryCollection($categories);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(CategoryStoreRequest $request)
    {
        $category = Category::create($request->all());
        return new CategoryResource($category);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(CategoryShowRequest $request,$id)
    {
        try{
            $category = Category::findOrFail($id);
            return new CategoryResource($category);
        }catch(\Exception $ex){
            return response()->json(['status'=>'not found'],404);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(CategoryUpdateRequest $request, $id)
    {
        try{
            $category = Category::findOrFail($id);
            $category->fill($request->all());
            return new CategoryResource($category);
        }catch(\Exception $ex){
            return response()->json(['status'=>'not found'],404);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(CategoryDestroyRequest $request, $id)
    {
        try{
            $category = Category::findOrFail($id);
            $category->delete();
            return new CategoryResource($category);
        }catch(\Exception $ex){
            return response()->json(['msg'=>'not found'],404);
        }
    }
}
