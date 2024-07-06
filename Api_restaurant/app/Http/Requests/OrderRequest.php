<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderRequest extends FormRequest
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
            // 'customer_id' => ['required'],
            'location_id' => ['nullable', 'integer'],
            'diningtable_id' => ['nullable', 'integer'],
            'total_cost'=>['required','numeric','min:1'],
          
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

    
    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            $data = $this->all();
    
            if (empty($data['location_id']) && empty($data['diningtable_id'])) {
                $validator->errors()->add('location_id_OR_diningtable_id', 'Either location_id (for delivery) or diningtable_id (for in-restaurant) must be provided.');
            } elseif (!empty($data['location_id']) && !empty($data['diningtable_id'])) {
                $validator->errors()->add('location_id_OR_diningtable_id', 'You cannot provide both location_id and diningtable_id. Provide only one location_id (for delivery) or diningtable_id (for in-restaurant).');
            }
    
            if (empty($data['meal_ids']) && empty($data['addon_ids']) && empty($data['extra_ids'])) {
                $validator->errors()->add('meal_ids_OR_addon_ids_OR_extra_ids', 'meal_ids or addon_ids or extra_ids must be provided.');
            }
        });
    }

}
