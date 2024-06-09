<?php

namespace App\Rules;

use Closure;
use GuzzleHttp\Client;
use Illuminate\Contracts\Validation\ValidationRule;

class ValidEmail implements ValidationRule
{
    protected $client;
    public function __construct()
    {
        $this->client= new Client();
    }
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */

    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $apiUrl = 'https://api.hunter.io/v2/email-verifier';
        $apiKey = env('HUNTER_API_KEY'); // Retrieve the API key from the .env file

        try {
            $response = $this->client->get($apiUrl, [
                'query' => [
                    'email' => $value,
                    'api_key' => $apiKey,
                ]
            ]);

            $data = json_decode($response->getBody(), true);

            if ($data['data']['result'] !== 'deliverable') {
                $fail('The :attribute must be a valid email address.');
            }
        } catch (\Exception $e) {
            
            $fail('The :attribute must be a valid email address.');
            
            //$e->getMessage()
            // $fail('Could not verify email address : ' .$value. $e->getMessage()  );
        }
    }
    
}
?>
