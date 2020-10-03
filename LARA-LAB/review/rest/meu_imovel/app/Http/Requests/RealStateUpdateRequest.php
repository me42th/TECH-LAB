<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RealStateUpdateRequest extends FormRequest
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
            'user_id' => 'exists:App\Models\User,id',
            'title' => 'max:255',
            'description' => 'max:255',
            'content' => 'max:255',
            'price' => 'numeric',
            'slug' => 'max:255',
            'bedrooms' => 'numeric',
            'bathrooms' => 'numeric',
            'property_area' => 'numeric',
            'total_property_area' => 'numeric'
        ];
    }
}
