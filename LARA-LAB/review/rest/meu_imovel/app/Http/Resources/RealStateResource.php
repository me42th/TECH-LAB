<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class RealStateResource extends JsonResource
{
    private $status,$code;
    public function __construct($realState,$code,$status){
        parent::__construct($realState);
        $this->status = $status;
        $this->code = $code;
    }
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        static::wrap('real_state');
        return [
            'id' => $this->id,
            'owner' => $this->user->name,
            'title' => $this->title,
            'description' => $this->description,
            'content' => $this->content,
            'price' => $this->price,
            'slug' => $this->slug,
            'bedrooms' => $this->bedrooms,
            'bathrooms' => $this->bathrooms,
            'property_area' => $this->property_area,
            'total_property_area' => $this->total_property_area
        ];
    }

    public function with($request){
        return [
            'status' => $this->status
        ];
    }
    public function withresponse($request,$response){
        $response->setStatusCode($this->code);
    }

}
