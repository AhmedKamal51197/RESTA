<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OfferAddonRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        // Allow authorization
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
            'addon_id' => ['required', 'exists:addons,id'],    
            'addon_quantity' => ['required', 'integer', 'min:1'],
        ];
    }

    public function messages(): array
    {
        return [
            'offer_id.required' => 'The offer ID is required.',
            'offer_id.exists' => 'The specified offer ID does not exist.',
            'addon_id.required' => 'The addon ID is required.',
            'addon_id.exists' => 'The specified addon ID does not exist.',
            'addon_quantity.required' => 'The addon quantity is required.',
            'addon_quantity.integer' => 'The addon quantity must be an integer.',
            'addon_quantity.min' => 'The addon quantity must be at least 1.',
        ];
    }
}
