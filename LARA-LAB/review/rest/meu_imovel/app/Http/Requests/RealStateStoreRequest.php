<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RealStateStoreRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'user_id' => 'required',
            'title' => 'required',
            'description' => 'required',
            'content' => 'required',
            'price' => 'required',
            'slug' => 'required',
            'bedrooms' => 'required',
            'bathrooms' => 'required',
            'property_area' => 'required',
            'total_property_area' => 'required'
        ];
    }
}
