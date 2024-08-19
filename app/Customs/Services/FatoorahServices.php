<?php

namespace App\Customs\Services;

use App\Models\Tax;
use GuzzleHttp\Client;
use Illuminate\Database\Eloquent\Model;
use GuzzleHttp\Psr7\Request;

class FatoorahServices
{
    private $base_url;
    private $headers;
    private $request_client;

    /**
     *  FatoorahService constructor
     * @param Client $request_client
     */
    public function __construct(Client $request_client)
    {
        $this->request_client = $request_client;
        $this->base_url = env('fatoora_base_url');
       // dd(env("fatoora_base_url"));
        $this->headers = [
            'Content-Type' => 'application/json',
            'authorization' => 'Bearer ' . env('fatoora_token')
        ];
    }
    public function buildRequest($url , $method, $data=[])
    {
        
        $request = new Request($method,$this->base_url . $url,$this->headers);
        //dd($this->base_url. $url );
        // if(!$data){
        // return false;
        //  }
        $response = $this->request_client->send($request, [
            'json'=>$data
        ]);
        // if($response->getStatusCode() != 200)
        // {
        //     return false;
        // }
        $response = json_decode($response->getBody(),true);
        // dd($response);
        return $response;
    }
    //data => array
    public function sendPayment($data)
    {
        $response = $this->buildRequest('/v2/SendPayment', 'POST', $data);
        return $response;
    }
    //data => array
    public function getPaymentStatus($data)
    {
       return $response= $this->buildRequest('/v2/getPaymentStatus','POST',$data);
    }

}
