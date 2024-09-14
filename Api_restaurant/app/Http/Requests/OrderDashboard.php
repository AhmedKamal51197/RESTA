<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderDashboard extends FormRequest
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
             'customer_id' => ['required','integer'],
            //'location_id' => ['nullable', 'integer'],
            'diningtable_id' => ['nullable', 'integer'],
            'total_cost'=>['required','numeric','min:1'],
            
            'offer_ids' => ['array', 'nullable'],
            'offer_ids.*.id' => ['required', 'integer'],
            'offer_ids.*.quantity' => ['required', 'integer', 'min:1'],
            'offer_ids.*.cost' => ['required', 'numeric', 'min:1'],

            'meal_ids' => ['array', 'nullable'],
            'meal_ids.*.id' => ['required', 'integer'],
            'meal_ids.*.quantity' => ['required', 'integer', 'min:1'],
            'meal_ids.*.cost' => ['required', 'numeric', 'min:1'],

            'addon_ids' => ['array', 'nullable'],
            'addon_ids.*.id' => ['required', 'integer'],
            'addon_ids.*.quantity' => ['required', 'integer', 'min:1'],
            'addon_ids.*.cost' => ['required', 'numeric', 'min:1'],

            'extra_ids' => ['array', 'nullable'],
            'extra_ids.*.id' => ['required', 'integer'],
            'extra_ids.*.quantity' => ['required', 'integer', 'min:1'],
            'extra_ids.*.cost' => ['required', 'numeric', 'min:1'],

            'notes'=>['string','nullable']
        ];
    }
}
