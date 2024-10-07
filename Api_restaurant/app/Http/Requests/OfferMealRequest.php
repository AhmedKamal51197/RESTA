<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

use App\Models\Meal;
// use Illuminate\Validation\Validator;


class OfferMealRequest extends FormRequest
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
            'meal_id' => ['required', 'exists:meals,id'],    
            'meal_quantity' => ['required', 'integer', 'min:1', 'max:100'],
            'meal_size' => ['required', 'integer', 'min:1', 'max:4', function ($attribute, $value, $fail) {
                $meal = Meal::find($this->meal_id);
                if (!$meal || !$meal->hasSize($value)) {
                    $fail("The selected meal size does not exist for the given meal.");
                }
            }]
        ];
    }

    /**
     * Customize error messages for validation rules.
     */
    public function messages(): array
    {
        return [
            'offer_id.required' => 'The offer ID is required.',
            'offer_id.exists' => 'The specified offer ID does not exist.',
            'meal_id.required' => 'The meal ID is required.',
            'meal_id.exists' => 'The specified meal ID does not exist.',
            'meal_quantity.required' => 'The meal quantity is required.',
            'meal_quantity.integer' => 'The meal quantity must be an integer.',
            'meal_quantity.min' => 'The meal quantity must be at least 1.',
            'meal_quantity.max' => 'The meal quantity must not exceed 100.',
            'meal_size.required' => 'The meal size is required.',
            'meal_size.integer' => 'The meal size must be an integer.',
            'meal_size.min' => 'The meal size must be at least 1.',
            'meal_size.max' => 'The meal size must not exceed 4.',
        ];
    }
}
