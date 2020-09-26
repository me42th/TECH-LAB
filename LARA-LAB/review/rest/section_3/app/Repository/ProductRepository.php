<?php

namespace App\Repository;

use App\Models\Product;
use Illuminate\Http\Request;


class ProductRepository extends AbstractRepository{

    public function __construct(Product $product, Request $request){
        parent::__construct($product,$request);
    }


}
