<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OfferRequest extends FormRequest
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
            'name'=>['required','string','min:6'],
            'discount'=>['required','integer'],
            'startDate'=>['required','date','before:endDate'],
            'endDate'=>['required','date','after:startDate'],
            'image'=>['image','mimes:jpeg,png,jpg,gif,svg','max:2048'],
            'status'=>['required','in:active,inactive']

        ];
    }
}
