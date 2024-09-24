<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OfferItemRequest extends FormRequest
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
            'meal_ids' => ['array', 'nullable'],
            'meal_ids.*.id' => ['required', 'integer'],
            'meal_ids.*.quantity' => ['required', 'integer', 'min:1'],

            'extra_ids' => ['array', 'nullable'],
            'extra_ids.*.id' => ['required', 'integer'],
            'extra_ids.*.quantity' => ['required', 'integer', 'min:1'],

            'addon_id' => ['array', 'nullable'],
            'addon_ids.*.id' => ['required', 'integer'],
            'addon_ids.*.quantity' => ['required', 'integer', 'min:1'],
        ];
    }

    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            $data = $this->all();
    
            if (empty($data['meal_ids']) && empty($data['addon_ids']) && empty($data['extra_ids'])) {
                $validator->errors()->add('meal_ids_OR_addon_ids_OR_extra_ids', 'meal_ids or addon_ids or extra_ids must be provided.');
            }
        });
    }
}
