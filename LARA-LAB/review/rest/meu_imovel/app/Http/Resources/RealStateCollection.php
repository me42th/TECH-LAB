<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\ResourceCollection;

class RealStateCollection extends ResourceCollection
{
    private $status;
    public function __construct($collection, $status){
        parent::__construct($collection);
        $this->status = $status;
    }
    public function toArray($request)
    {
        static::withoutWrapping();
        return [
            'data' => $this->collection,
            'links' => ''
        ];
    }

    public function with($request){
        return ['status' => $this->status];
    }

    public function withResponse($request,$response){
        $response->setStatusCode(420,'Just relax');
    }
}
