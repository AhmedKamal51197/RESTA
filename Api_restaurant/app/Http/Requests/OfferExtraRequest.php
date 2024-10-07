<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OfferExtraRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'offer_id' => ['required', 'exists:offers,id'], 
            'extra_id' => ['required', 'exists:extras,id'],    
            'extra_quantity' => ['required', 'integer', 'min:1'],
        ];
    }

    public function messages(): array
    {
        return [
            'offer_id.required' => 'The offer ID is required.',
            'offer_id.exists' => 'The specified offer ID does not exist.',
            'extra_id.required' => 'The extra ID is required.',
            'extra_id.exists' => 'The specified extra ID does not exist.',
            'extra_quantity.required' => 'The extra quantity is required.',
            'extra_quantity.integer' => 'The extra quantity must be an integer.',
            'extra_quantity.min' => 'The extra quantity must be at least 1.',
        ];
    }
}
