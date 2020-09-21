<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{


    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        //JsonResource::withoutWrapping();
        JsonResource::wrap('product');

        return [
            'id' => $this->id,
            'name' => $this->name,
            'price' => $this->price,
            'description' => $this->description
        ];
    }

    public function with($request){
        return [
            'extra_information' => 'some important stuff',
            'other' => 'be happy brow'
        ];
    }
}
