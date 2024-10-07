<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OfferUpdateRequest extends FormRequest
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
            'name'=>['string','min:6'],
            'discount'=>['integer'],
            'startDate'=>['date','before:endDate'],
            'endDate'=>['date','after:startDate'],
            'image'=>['image','mimes:jpeg,png,jpg,gif,svg','max:2048'],
            'status'=>['in:0,1']
        ];
    }
}
