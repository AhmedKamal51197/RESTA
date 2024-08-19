<?php

namespace App\Http\Controllers;

use App\Customs\Services\FatoorahServices;
use Illuminate\Http\Request;

class FatoorahController extends Controller
{
    private $fatoorahServices;
    public function __construct(FatoorahServices $fatoorahServices)
    {
        $this->fatoorahServices = $fatoorahServices;
    }
    public function payOrder()
    {

        $data = [
            'CustomerName' => 'Ahmed kamal',
            'NotificationOption' => 'LNK',
            'InvoiceValue' => 100,
            'CustomerEmail' => 'ahmed.ka51197@gmail.com',
            'CallBackUrl' => env('success_url'),
            'ErrorUrl' => env('error_url'),
            'Language' => 'en',
            'DisplayCurrencyIso' => 'OMR'
        ];
        return   $this->fatoorahServices->sendPayment($data);
    }
    public function paymentCallBack(Request $request)
    {
        $data = [
            'Key' => $request->paymentId,
            'KeyType' => 'paymentId'
        ];
        return $this->fatoorahServices->getPaymentStatus($data);
    }
}
