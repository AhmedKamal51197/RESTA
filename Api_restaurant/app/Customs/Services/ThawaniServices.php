<?php 
// namespace App\Services\Payments;

// use Exception;
// use Illuminate\Support\Facades\Http;

// class Thawani 
// {
//     const TEST_BASE_URL="https://uatcheckout.thawani.om/api/v1";
//     const LIVE_BASE_URL="https://checkout.thawani.om/api/v1";
//     protected $secret_key;
//     protected $publish_key;
//     protected $baseUrl;
//     protected $mode;

//     public function __construct($secret_key,$publish_key,$mode='test')
//     {
//         $this->secret_key=$secret_key;
//         $this->publish_key=$publish_key;
//         $this->mode=$mode;
//         if($mode==='test')
//         {
//            $this->baseUrl=self::TEST_BASE_URL; 
//         }
//         else 
//         {
//             $this->baseUrl=self::LIVE_BASE_URL;
//         }
//     }

//     public function createCheckoutSession($data)
//     {
//        $response=Http::baseUrl($this->baseUrl)
//         ->withHeaders([ 
//             'thawani-api-key'=>$this->secret_key,
//         ])
//         ->asJson()
//         ->post('checkout/session',[
//             'client_reference_id'=>$data['client_reference_id'],
//             'mode'=>'payment',
//             'products'=>$data,
//             'success_url'=>'http://localhost:3000/customer/paymentsucceded',
//             'cancel_url'=>'http://localhost:3000/customer/paymentfailed'
//         ]);

//         $body=$response()->json();
//         if($body['success']===true &&$body['code']===2004)
//         {
//                return $body['data']['session_id']; 
//         }

//         throw new Exception($body['description'], $body['code']);
//     }
// }

namespace App\Customs\Services;

use Exception;
use GuzzleHttp\Client;
use GuzzleHttp\Psr7\Request;

class ThawaniServices
{
    private $base_url;
    private $headers;
    private $request_client;

    /**
     * ThawaniServices constructor
     * @param Client $request_client
     */
    public function __construct(Client $request_client)
    {
        $this->request_client = $request_client;

        // Determine the base URL based on the mode (test or live)
        $mode = env('THAWANI_MODE', 'test'); // Default to 'test' if not set
        
        if ($mode === 'live') {
            $this->base_url = 'https://checkout.thawani.om/api/v1';
        } else {
            $this->base_url = 'https://uatcheckout.thawani.om/api/v1';
        }

        $this->headers = [
            'Content-Type'    => 'application/json',
            'thawani-api-key' => env('THWANI_SECRET_KEY'),
        ];
    }

    /**
     * Build and send a request to Thawani API
     */
    public function buildRequest($url, $method, $data = [])
    {
        $request = new Request($method, $this->base_url . $url, $this->headers);

        $options = [];
        if (!empty($data)) {
            $options['json'] = $data;
        }

        $response = $this->request_client->send($request, $options);

        $response = json_decode($response->getBody(), true);

        return $response;
    }

    /**
     * Create a checkout session (similar to sendPayment)
     */
    public function sendPayment($data)
    {
        $response = $this->buildRequest('/checkout/session', 'POST', $data);

        if ($response['success'] === true && $response['code'] === 2004) {
            return $response['data'];
        }

        throw new Exception($response['description'], $response['code']);
    }

    /**
     * Get payment status using session ID (similar to getPaymentStatus)
     */
    public function getPaymentStatus($sessionId)
    {
        $response = $this->buildRequest('/checkout/session/' . $sessionId, 'GET');

        if ($response['success'] === true && $response['code'] === 2000) {
            return $response['data'];
        }

        throw new Exception($response['description'], $response['code']);
    }
}