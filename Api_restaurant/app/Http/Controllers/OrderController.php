<?php

namespace App\Http\Controllers;

use App\Customs\Services\FatoorahServices;
use App\Customs\Services\ThawaniServices;
use App\Http\Requests\OrderDashboard;
use App\Http\Requests\OrderRequest;
use App\Models\Addon;
use App\Models\Customer;
use App\Models\DiningTable;
use App\Models\Extra;
use App\Models\Meal;
use App\Models\Offer;
use App\Models\Order;
use App\Models\Order_offer;
use App\Models\OrderAddon;
use App\Models\OrderExtra;
use App\Models\OrderLocation;
use App\Models\OrderMeal;
use App\Models\Transaction;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Auth\Events\Validated;
use Illuminate\Contracts\Support\ValidatedData;
use Illuminate\Support\Facades\Auth;

// use function PHPSTORM_META\map;

class OrderController extends Controller
{
    // private $fatoorahServices;
    // public function __construct(FatoorahServices $fatoorahServices)
    // {
    //     $this->fatoorahServices = $fatoorahServices;
    // }
    private $thawaniServices;

    public function __construct(ThawaniServices $thawaniServices)
    {
        $this->thawaniServices = $thawaniServices;
    }

    public function index()
    {

        $orders = Order::with(['customer', 'orderAddons.addon', 'orderMeals.meal', 'orderExtras.extra'])->get();


        if ($orders->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No orders have placed yet!'
            ], 404);
        }
        //  dd($orders[0]->status);


        return response()->json([
            'status' => 'success',
            'data' => $orders,

        ], 200);
    }
    public function get_order_meals($id)
    {
        $order_meals = OrderMeal::where('order_id', $id)->get();

        if ($order_meals->isEmpty()) return response()->json([
            'status' => 'failed',
            'message' => 'No meals found',
        ], 404);
        foreach ($order_meals as $order_meal) {

            $meal = Meal::find($order_meal->meal_id);
            $order_meal->meal_name = $meal ? $meal->name : null;
            $order_meal->meal_image = $meal ? $meal->image : null;
        }

        return response()->json([
            'status' => 'success',
            'data' => $order_meals,

        ], 200);
    }


    public function get_order_addons($id)
    {
        $order_addons = OrderAddon::where('order_id', $id)->get();
        if ($order_addons->isEmpty()) return response()->json([
            'status' => 'failed',
            'message' => 'No addons found',
        ], 404);
        foreach ($order_addons as $order_addon) {

            $addon = Addon::find($order_addon->addon_id);


            $order_addon->addon_name = $addon ? $addon->name : null;
            $order_addon->addon_image = $addon ? $addon->image : null;
        }

        return response()->json([
            'status' => 'success',
            'data' => $order_addons,

        ], 200);
    }
    public function get_order_extras($id)
    {
        $orders = OrderExtra::where('order_id', $id)->get();

        if ($orders->isEmpty()) return response()->json([
            'status' => 'failed',
            'message' => 'No Extras found'
        ], 404);
        foreach ($orders as $order) {
            $extra = Extra::find($order->extra_id);
            $order->extra_name = $extra->name;
            $order->extra_image = $extra->image;
        }

        return response()->json([
            'status' => 'success',
            'data' => $orders,

        ], 200);
    }
    public function show($id)
    {
        $order = Order::with(['customer', 'orderAddons.addon', 'orderMeals.meal', 'orderExtras.extra'])->find($id);
        if (!$order) return response()->json([
            'status' => 'failed',
            'message' => 'No Order Found'
        ], 404);


        return response()->json([
            'status' => 'success',
            'data' => $order
        ], 200);
    }
    
    // // order with online payment
    // public function payOrder(OrderRequest $request)
    // {


    //     $validatedData = $request->validated();
    //     $mealIds = $validatedData['meal_ids'] ?? [];
    //     $addonIds = $validatedData['addon_ids'] ?? [];
    //     $extraIds = $validatedData['extra_ids'] ?? [];
    //     $offerIds = $validatedData['offer_ids'] ?? [];

    //     //  dd($validatedData['diningtable_id']) ;  
    //     if (isset($validatedData['diningtable_id'])) {
    //         $diningtable = $this->checkDiningTable($validatedData['diningtable_id']);
    //         if ($diningtable instanceof JsonResponse) return $diningtable;
    //     }
    //     if (isset($validatedData['location_id'])) {
    //         $location = $this->checkLocation($validatedData['location_id']);
    //         if ($location instanceof JsonResponse) return $location;
    //     }
    //     // if (isset($validatedData['customer_id'])) {
    //     //     $customer = $this->checkCustomer($validatedData['customer_id']);
    //     //     if ($customer instanceof JsonResponse) return $customer;
    //     // }
    //     DB::beginTransaction();
    //     try {

    //         $order = Order::create([
    //             'customer_id' => auth('api')->id(),
    //             'location_id' => $validatedData['location_id'] ?? null,
    //             'DiningTable_id' => $validatedData['diningtable_id'] ?? null,
    //             'total_cost' => $validatedData['total_cost'],
    //             'notes' => $validatedData['notes'] ?? null,
    //             'PaymentType' => "online"
    //         ]);
    //         foreach ($offerIds as $offerId) {
    //             $offer = $this->checkOffer($offerId);
    //             if ($offer instanceof JsonResponse) return $offer;
    //             Order_offer::create([
    //                 'order_id' => $order->id,
    //                 'offer_id' => $offerId['id'],
    //                 'quantity' => $offerId['quantity'],
    //                 'total_cost' => $offerId['cost'] * $offerId['quantity']
    //             ]);
    //         }
    //         foreach ($mealIds as $mealId) {
    //             // dd(Meal::find($mealId['id']));
    //             $meal =  $this->checkMeal($mealId['id']);
    //             if ($meal instanceof JsonResponse) return $meal;
    //             OrderMeal::create([
    //                 'order_id' => $order->id,
    //                 'meal_id' => $mealId['id'],
    //                 'quantity' => $mealId['quantity'],
    //                 'total_cost' => $mealId['cost'] * $mealId['quantity'],
    //             ]);
    //         }
    //         foreach ($addonIds as $addonId) {
    //             $addon =  $this->checkAddon($addonId['id']);
    //             if ($addon instanceof JsonResponse) return $addon;
    //             OrderAddon::create([
    //                 'order_id' => $order->id,
    //                 'addon_id' => $addonId['id'],
    //                 'quantity' => $addonId['quantity'],
    //                 'total_cost' => $addonId['cost'] * $addonId['quantity'],
    //             ]);
    //         }
    //         foreach ($extraIds as $extraId) {
    //             $extra = $this->checkExtra($extraId['id']);
    //             if ($extra instanceof JsonResponse)
    //                 return $extra;
    //             OrderExtra::create([
    //                 'order_id' => $order->id,
    //                 'extra_id' => $extraId['id'],
    //                 'quantity' => $extraId['quantity'],
    //                 'total_cost' => $extraId['cost'] * $extraId['quantity']
    //             ]);
    //         }
    //         DB::commit();
    //         // return response()->json([
    //         //     'status' => 'success',
    //         //     'message' => 'Order created successfully'
    //         // ], 201);
    //         $data = [
    //             'CustomerName' => auth('api')->user()->name,
    //             'NotificationOption' => 'LNK',
    //             'InvoiceValue' => $validatedData['total_cost'],
    //             'CustomerEmail' => auth('api')->user()->email,
    //             'CallBackUrl' => env('success_url'),
    //             'ErrorUrl' => env('error_url'),
    //             'Language' => 'en',
    //             'DisplayCurrencyIso' => 'OMR'
    //         ];
    //         // dd($order->total_cost);

    //         $data = $this->fatoorahServices->sendPayment($data);
    //         // dd($data);
    //         $transaction = Transaction::create([
    //             'customer_id' => auth('api')->id(),
    //             'order_id' => $order->id,
    //             'amount' => $order->total_cost,
    //             'InvoiceId' => $data['Data']['InvoiceId'],
    //         ]);

    //         return response()->json([
    //             'status' => 'success',
    //             'Transaction_id' => $transaction->id,
    //             'Invoice Data' => $data
    //         ], 200);
    //     } catch (Exception $e) {
    //         DB::rollBack();
    //         return response()->json([
    //             'status' => 'failed',
    //             'message' => $e->getMessage()
    //         ], 400);
    //     }
    // }
    // Order with online payment
    public function payOrder(OrderRequest $request)
    {
        $validatedData = $request->validated();
        $mealIds       = $validatedData['meal_ids'] ?? [];
        $addonIds      = $validatedData['addon_ids'] ?? [];
        $extraIds      = $validatedData['extra_ids'] ?? [];
        $offerIds      = $validatedData['offer_ids'] ?? [];

        if (isset($validatedData['diningtable_id'])) {
            $diningtable = $this->checkDiningTable($validatedData['diningtable_id']);
            if ($diningtable instanceof JsonResponse) return $diningtable;
        }
        if (isset($validatedData['location_id'])) {
            $location = $this->checkLocation($validatedData['location_id']);
            if ($location instanceof JsonResponse) return $location;
        }

        DB::beginTransaction();
        try {
            $order = Order::create([
                'customer_id'    => auth('api')->id(),
                'location_id'    => $validatedData['location_id'] ?? null,
                'DiningTable_id' => $validatedData['diningtable_id'] ?? null,
                'total_cost'     => $validatedData['total_cost'],
                'notes'          => $validatedData['notes'] ?? null,
                'PaymentType'    => "online"
            ]);

            // Handle offers, meals, addons, and extras (same as your original code)
            // ...

            DB::commit();

            // Prepare data for Thawani
            $data = [
                'client_reference_id' => $order->id,
                'products'            => [
                    [
                        'name'        => 'Order #' . $order->id,
                        'unit_amount' => $order->total_cost * 100, // Amount in Baisa
                        'quantity'    => 1,
                    ],
                ],
                'success_url' => env('success_url'),
                'cancel_url'  => env('error_url'),
                'metadata'    => [
                    'order_id' => $order->id,
                ],
            ];
            
            // Create a checkout session
            $paymentData = $this->thawaniServices->sendPayment($data);
            dd($paymentData['session_id']);
            // Save transaction
            $transaction = Transaction::create([
                'customer_id' => auth('api')->id(),
                'order_id'    => $order->id,
                'amount'      => $order->total_cost,
                'InvoiceId'   => $paymentData['session_id'],
            ]);

            return response()->json([
                'status'          => 'success',
                'Transaction_id'  => $transaction->id,
                'Payment_URL'     => 'https://uatcheckout.thawani.om/pay/' . $paymentData['session_id'], // Use live URL if in production
                'Invoice Data'    => $paymentData
            ], 200);

        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'failed',
                'message' => $e->getMessage()
            ], 400);
        }
    }

    // public function paymentCallBack(Request $request)
    // {
    //     $data = [
    //         'Key' => $request->paymentId,
    //         'KeyType' => 'paymentId'
    //     ];
    //     $paymentStatus = $this->fatoorahServices->getPaymentStatus($data);

    //     //dd($paymentStatus);
    //     //$email=$paymentStatus['Data']['CustomerEmail'];
    //     // $transaction=Transaction::with(['customer', 'order'])
    //     // ->whereHas('customer', function ($query) use ($email) {
    //     //     $query->where('email', $email);
    //     // })
    //     //->first();
    //     // dd($transaction);
    //     // $paymentStatus['Data']['InvoiceId'];
    //     // dd($paymentStatus['Data']['InvoiceId']);
    //     if ($paymentStatus['IsSuccess']) {
    //         $invoiceId = $paymentStatus['Data']['InvoiceId'];
    //         $transaction = Transaction::where('InvoiceId', $invoiceId)->first();
    //         //dd($invoiceId);
    //         $order = Order::find($transaction->order_id);
    //         $order->pay = 1;
    //         $order->save();
    //         $transaction->payment_method = 'VisaMasterCard';
    //         $transaction->save();
    //         return response()->json([
    //             'status' => 'success',
    //             'message' => 'Payment was successful!'
    //         ], 200);
    //     }
    // }

    public function paymentCallBack(Request $request)
    {
        $sessionId = $request->session_id; // Thawani sends session_id in the callback URL

        try {
            $paymentStatus = $this->thawaniServices->getPaymentStatus($sessionId);

            if ($paymentStatus['payment_status'] === 'paid') {
                $transaction = Transaction::where('InvoiceId', $sessionId)->first();
                $order       = Order::find($transaction->order_id);

                $order->pay = 1;
                $order->save();

                $transaction->payment_method = 'Thawani';
                $transaction->save();

                return response()->json([
                    'status'  => 'success',
                    'message' => 'Payment was successful!'
                ], 200);
            }

            return response()->json([
                'status'  => 'failed',
                'message' => 'Payment not completed.'
            ], 400);

        } catch (Exception $e) {
            return response()->json([
                'status'  => 'failed',
                'message' => $e->getMessage()
            ], 400);
        }
    }
    // public function callbackError()
    // {
    //     return response()->json([
    //         'status' => 'failed',
    //         'message' => 'Error occured in payment please try again'
    //     ], 404);
    // }
    public function callbackError()
    {
        return response()->json([
            'status'  => 'failed',
            'message' => 'Error occurred in payment, please try again'
        ], 404);
    }
    // order without payment online 
    public function store(OrderRequest $request)
    {

        $validatedData = $request->validated();
        $mealIds = $validatedData['meal_ids'] ?? [];
        $addonIds = $validatedData['addon_ids'] ?? [];
        $extraIds = $validatedData['extra_ids'] ?? [];
        $offerIds = $validatedData['offer_ids'] ?? [];
        //  dd($validatedData['diningtable_id']) ;  
        if (isset($validatedData['diningtable_id'])) {
            $diningtable = $this->checkDiningTable($validatedData['diningtable_id']);
            if ($diningtable instanceof JsonResponse) return $diningtable;
        }
        if (isset($validatedData['location_id'])) {
            $location = $this->checkLocation($validatedData['location_id']);
            if ($location instanceof JsonResponse) return $location;
        }
        // if (isset($validatedData['customer_id'])) {
        //     $customer = $this->checkCustomer($validatedData['customer_id']);
        //     if ($customer instanceof JsonResponse) return $customer;
        // }
        DB::beginTransaction();
        try {

            $order = Order::create([
                'customer_id' => auth('api')->id(),
                'location_id' => $validatedData['location_id'] ?? null,
                'DiningTable_id' => $validatedData['diningtable_id'] ?? null,
                'total_cost' => $validatedData['total_cost'],
                'notes' => $validatedData['notes'] ?? null,
                'PaymentType' => "cashed",
                'created_by'=>1
            ]);
            foreach ($offerIds as $offerId) {
                $offer = $this->checkOffer($offerId);
                if ($offer instanceof JsonResponse) return $offer;
                Order_offer::create([
                    'order_id' => $order->id,
                    'offer_id' => $offerId['id'],
                    'quantity' => $offerId['quantity'],
                    'total_cost' => $offerId['cost'] * $offerId['quantity']
                ]);
            }
            foreach ($mealIds as $mealId) {
                // dd(Meal::find($mealId['id']));
                $meal =  $this->checkMeal($mealId['id']);
                if ($meal instanceof JsonResponse) return $meal;
                OrderMeal::create([
                    'order_id' => $order->id,
                    'meal_id' => $mealId['id'],
                    'quantity' => $mealId['quantity'],
                    'total_cost' => $mealId['cost'] * $mealId['quantity'],
                ]);
            }
            foreach ($addonIds as $addonId) {
                $addon =  $this->checkAddon($addonId['id']);
                if ($addon instanceof JsonResponse) return $addon;
                OrderAddon::create([
                    'order_id' => $order->id,
                    'addon_id' => $addonId['id'],
                    'quantity' => $addonId['quantity'],
                    'total_cost' => $addonId['cost'] * $addonId['quantity'],
                ]);
            }
            foreach ($extraIds as $extraId) {
                $extra = $this->checkExtra($extraId['id']);
                if ($extra instanceof JsonResponse)
                    return $extra;
                OrderExtra::create([
                    'order_id' => $order->id,
                    'extra_id' => $extraId['id'],
                    'quantity' => $extraId['quantity'],
                    'total_cost' => $extraId['cost'] * $extraId['quantity']
                ]);
            }
            DB::commit();
            Transaction::create([
                'customer_id' => auth('api')->id(),
                'order_id' => $order->id,
                'payment_method' => 'cashed',
                'amount' => $order->total_cost
            ]);



            return response()->json([
                'status' => 'success',
                'message' => 'Order created successfully'
            ], 201);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'failed',
                'message' => $e->getMessage()
            ], 400);
        }
    }
    // retrieve all customers to Dashboard Create order 
    public function retrieveCustomers()
    {
        $customers = Customer::all();
        $customers=$customers->map(function ($customer){
            return [
                'name'=>$customer->name,
                'email'=>$customer->email,
                'id'=>$customer->id
            ];
        });
        return response()->json([
            'status'=>'success',
            'data'=>$customers
        ],200);
    }
    // retrieve all item for dashboard make order 
    public function AllItems(Request $request)
    {
        $perPage = 12;
        
        $meals = [];
        $addons = [];
        $extras = [];
        $offers = [];
        $offersQuery = Offer::where('status',1);
        $offers=$offersQuery->get()->map(function($offer){

            $offer['table_name']='offers';
            return $offer;
        })->toArray();
        // var_dump($offers);
        $mealsQuery = Meal::where('status', 1);
        if ($request->has('category_id')) {
            $mealsQuery->where('category_id', $request->category_id);
        }
        $meals = $mealsQuery->get()->map(function ($meal) {
            $mealData = $this->DataMeal($meal);
            $mealData['table_name'] = 'meals';
            return $mealData;
        })->toArray();

        $addonsQuery = Addon::where('status', 1);
        if ($request->has('category_id')) {
            $addonsQuery->where('category_id', $request->category_id);
        }
        $addons = $addonsQuery->get()->map(function ($addon) {
            $addon['table_name'] = 'addons'; 
            return $addon;
        })->toArray();

        $extrasQuery = Extra::where('status', 1);
        if ($request->has('category_id')) {
            $extrasQuery->where('category_id', $request->category_id);
        }
        $extras = $extrasQuery->get()->map(function ($extra) {
            $extra['table_name'] = 'extras'; 
            return $extra;
        })->toArray();

        $allItems = array_merge($meals, $addons, $extras,$offers);
        // dd($allItems);
        $totalItems = count($allItems);
        $currentPage = $request->query('page', 1);
        $offset = ($currentPage - 1) * $perPage;
        $itemsForPage = array_slice($allItems, $offset, $perPage);
        $lastPage = ceil($totalItems / $perPage);

        $pagination = [
            'total' => $totalItems,
            'per_page' => $perPage,
            'current_page' => $currentPage,
            'last_page' => $lastPage,
        ];
        //var_dump($itemsForPage);
        if(empty($itemsForPage))
        {
            return response()->json([
                'status' => 'failed',
                'message' => 'No data in this page',
            ], 404);    
        }
        return response()->json([
            'status' => 'success',
            'data' => $itemsForPage,
            'pagination' => $pagination,
        ], 200);
    }
      // meals get data
      private function DataMeal($meal)
      {
          // Fetch meal size costs
          $mealCosts = $meal->mealSizeCosts->map(function ($sizeCost) {
              $costData = [
                  'id' => $sizeCost->id,
              ];
  
              if (!is_null($sizeCost->number_of_pieces)) {
                  $costData['number_of_pieces'] = $sizeCost->number_of_pieces;
              }
  
              if (!is_null($sizeCost->size)) {
                  $costData['size'] = $sizeCost->size;
              }
  
              $costData['cost']= $sizeCost->cost;
              return $costData;
          });
  
          // Fetch addons based on user role and addon status
          $addons = $meal->MealWithAddon->map(function ($mealWithAddon) {
              $addon = $mealWithAddon->addon; // all addons
              
              if (Auth::guard('admin-api')->check() || $addon->status) { 
                  return [
                      'id' => $addon->id,
                      'name' => $addon->name,
                      'cost' => $addon->cost,
                      'description' => $addon->description,
                      'category_id' => $addon->category_id,
                      'image' => $addon->image,
                  ];
              }
  
              return null;
          })->filter()->values();
  
          $extras = $meal->extras->map(function ($extra) {
              if (Auth::guard('admin-api')->check() || $extra->status) {
                  return [
                      'id' => $extra->id,
                      'name' => $extra->name,
                      'cost' => $extra->cost,
                      'category_id' => $extra->category_id,
                  ];
              }
              return null;
          })->filter()->values();
  
          return [
              'id' => $meal->id,
              'name' => $meal->name,
              'description' => $meal->description,
              'type' => $meal->type,
              'category_id' => $meal->category_id,
              'image' => $meal->image,
              'status' => $meal->status,
              'meal_size_costs' => $mealCosts->isEmpty() ? null : $mealCosts,
              'addons' => $addons->isEmpty() ? null : $addons,
              'extras' =>$extras->isEmpty() ? null : $extras
          ];
      }
    // create order for Dashboard
    public function storeOrderDashboard(OrderDashboard $request)
    {

        $validatedData = $request->validated();
        $mealIds = $validatedData['meal_ids'] ?? [];
        $addonIds = $validatedData['addon_ids'] ?? [];
        $extraIds = $validatedData['extra_ids'] ?? [];
        $offerIds = $validatedData['offer_ids'] ?? [];
        //  dd($validatedData['diningtable_id']) ;  
        if (isset($validatedData['diningtable_id'])) {
            $diningtable = $this->checkDiningTable($validatedData['diningtable_id']);
            if ($diningtable instanceof JsonResponse) return $diningtable;
        }
        if (isset($validatedData['location_id'])) {
            $location = $this->checkLocation($validatedData['location_id']);
            if ($location instanceof JsonResponse) return $location;
        }
        // if (isset($validatedData['customer_id'])) {
        //     $customer = $this->checkCustomer($validatedData['customer_id']);
        //     if ($customer instanceof JsonResponse) return $customer;
        // }
        DB::beginTransaction();
        try {

            $order = Order::create([
                'customer_id' => auth('api')->id(),
                'location_id' => $validatedData['location_id'] ?? null,
                'DiningTable_id' => $validatedData['diningtable_id'] ?? null,
                'total_cost' => $validatedData['total_cost'],
                'notes' => $validatedData['notes'] ?? null,
                'PaymentType' => "cashed"
            ]);
            foreach ($offerIds as $offerId) {
                $offer = $this->checkOffer($offerId);
                if ($offer instanceof JsonResponse) return $offer;
                Order_offer::create([
                    'order_id' => $order->id,
                    'offer_id' => $offerId['id'],
                    'quantity' => $offerId['quantity'],
                    'total_cost' => $offerId['cost'] * $offerId['quantity']
                ]);
            }
            foreach ($mealIds as $mealId) {
                // dd(Meal::find($mealId['id']));
                $meal =  $this->checkMeal($mealId['id']);
                if ($meal instanceof JsonResponse) return $meal;
                OrderMeal::create([
                    'order_id' => $order->id,
                    'meal_id' => $mealId['id'],
                    'quantity' => $mealId['quantity'],
                    'total_cost' => $mealId['cost'] * $mealId['quantity'],
                ]);
            }
            foreach ($addonIds as $addonId) {
                $addon =  $this->checkAddon($addonId['id']);
                if ($addon instanceof JsonResponse) return $addon;
                OrderAddon::create([
                    'order_id' => $order->id,
                    'addon_id' => $addonId['id'],
                    'quantity' => $addonId['quantity'],
                    'total_cost' => $addonId['cost'] * $addonId['quantity'],
                ]);
            }
            foreach ($extraIds as $extraId) {
                $extra = $this->checkExtra($extraId['id']);
                if ($extra instanceof JsonResponse)
                    return $extra;
                OrderExtra::create([
                    'order_id' => $order->id,
                    'extra_id' => $extraId['id'],
                    'quantity' => $extraId['quantity'],
                    'total_cost' => $extraId['cost'] * $extraId['quantity']
                ]);
            }
            DB::commit();
            Transaction::create([
                'customer_id' => auth('api')->id(),
                'order_id' => $order->id,
                'payment_method' => 'cashed',
                'amount' => $order->total_cost
            ]);



            return response()->json([
                'status' => 'success',
                'message' => 'Order created successfully'
            ], 201);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'failed',
                'message' => $e->getMessage()
            ], 400);
        }
    }
    public function get_user_orders($userId)
    {

        $orders = Order::with(['customer', 'orderAddons.addon', 'orderMeals.meal', 'orderExtras.extra'])->where('customer_id', $userId)->get();
        //  dd($orders->isEmpty());
        if ($orders->isEmpty()) return response()->json([
            'status' => 'failed',
            'message' => 'No orders are made with that Customer'
        ], 404);

        return response()->json([
            'status' => 'success',
            'data' => $orders,
        ], 200);
    }

    public function getAllTransactions()
    {
        $transactions = Transaction::all();


        if ($transactions->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No transaction found'
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'data' => $transactions,
        ]);
    }
    public function getTransactionById($id)
    {
        $transaction = Transaction::find($id);
        if (!$transaction) return response()->json([
            'status' => 'failed',
            'message' => 'No Transaction Found'
        ], 404);
        return response()->json([
            'status' => 'success',
            'data' => $transaction
        ], 200);
    }
    //Accepted Orders Ratio 
    public function AcceptedOrders(Request $request)
    {

        $startDate = Carbon::parse($request->from)->startOfDay(); //startOfDay() to ensure entire days specified  not just the exact times given.
        $endDate = Carbon::parse($request->to)->endOfDay();
        // dd($startDate);
        //selectRaw this use to make it easy to write complex sql query that can't write in Elquent ORM  
        $averageAcceptedOrderRatio = Order::selectRaw('
       (SELECT COUNT(*) FROM orders WHERE created_at BETWEEN ? AND ? AND status = "4") / 
       (SELECT COUNT(*) FROM orders WHERE created_at BETWEEN ? AND ?) AS average_accepted_order_ratio
        ', [$startDate, $endDate, $startDate, $endDate])
            ->value('average_accepted_order_ratio');
        if (!$averageAcceptedOrderRatio) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Orders not found'
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'sales' => $averageAcceptedOrderRatio
        ], 200);
    }
    //sales summary filter by Date for Dashboard 
    public function SalesSummary(Request $request)
    {
        $startDate = Carbon::parse($request->from)->startOfDay(); //startOfDay() to ensure entire days specified  not just the exact times given.
        $endDate = Carbon::parse($request->to)->endOfDay();
        // dd($startDate);
        $sales = Order::whereBetween('created_at', [$startDate, $endDate])->get();
        $salesResponse = $sales->map(function ($sale) {
            return [
                'Date' => $sale->created_at,
                'sales' => $sale->total_cost
            ];
        });
        if ($salesResponse->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'sales not found'
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'sales' => $salesResponse
        ], 200);
    }
    //Most Popular Items NOT EMPLEMENT YET 
    public function MostPopularItems()
    {
        
        $order = Order::all();
        // Group meals, count occurrences, and order by count descending
        $mealsWithCount = $order->flatMap(function ($order) {
            return $order->orderMeals->pluck('meal');
        })->groupBy('id')
        ->map(function ($meals) {
            return [
                'meal' => $meals->first(), // Get the meal details
                'count' => $meals->count()  // Count how many times this meal appears in orders
            ];
        })->sortByDesc('count'); // Sort by count in descending order
        // Group addons, count occurences, and order by count desscending
        $addonsWithCount = $order->flatMap(function($order){
            return $order->orderAddons->pluck('addon');
        })->groupBy('id')
        ->map(function($addons){
            return [
                'addon'=>$addons->first(),
                'count'=>$addons->count()
            ];
        })->sortByDesc('count');
        // Group extras, count occurences, and order by count desscending
        $extrasWithCount = $order->flatMap(function($order){
            return $order->orderExtras->pluck('extra');
        })->groupBy('id')
        ->map(function($addons){
            return [
                'extra'=>$addons->first(),
                'count'=>$addons->count()
            ];
        })->sortByDesc('count');
        return response()->json([
            'status'=>'success',
            'meals_occurences'=>$mealsWithCount->values(),
            'addons_occurences'=>$addonsWithCount->values(),
            'extras_occurences'=>$extrasWithCount->values()
        ],200);
    }
    //update order status  
    public function changeStatus(Request $request, $id)
    {
        $validatedData = $request->validate([
            'status' => ['required', 'in:Not Started,In Progress,Cancelled,Accepted']
        ]);
        $order = Order::find($id);
        if (!$order) return response()->json([
            'status' => 'failed',
            'message' => 'Order not found'
        ], 404);
        $order->status = $validatedData['status'];
        $order->save();
        return response()->json([
            'status' => 'success',
            'message' => 'change status successfully'
        ], 200);
    }

    /**
     * Generate Items Report 
     */
    // public function ItemsReport()
    // {
    //     $Items = [];
    //     $addons = OrderAddon::with('addon')->get();
    //     $addonsResponse = $addons->map(function($addon){
    //         return [
    //             'name'=>$addon->name,
    //             ''
    //         ];
    //     })
    //     return response()->json([
    //         'status'=>'success',
    //         'Items'=>$addons
    //     ],200);
    // }
    // change pay to paid if casher checked that customer paid cashed
    public function checkPaid(Request $request ,$id)
    {
        $validatedData = $request->validate([
            'pay'=>'in:0,1'
        ]);
        $order = Order::find($id);
        if(!$order) return response()->json([
            'status'=>'failed',
            'message'=>'No order found'
        ],404);
        $order->pay=$validatedData['pay'];
        $order->save();
        return response()->json([
            'status'=>'success',
            'message'=>'change paid status success'
        ],200);
    }
    // to use it in make order to check if ids that come from request existing in DB
    private function checkCustomer($id)
    {
        $customer = Customer::find($id);
        if (!$customer) return response()->json([
            'status' => 'failed',
            'message' => 'customer not found'
        ], 404);
        return $customer;
    }
    private function checkOffer($id)
    {
        $offer = Offer::find($id);
        if (!$offer) return response()->json([
            'status' => 'failed',
            'message' => 'Offer not found or Expired'
        ], 404);
        return $offer;
    }
    private function checkAddon($id)
    {
        $addon = Addon::find($id);
        if (!$addon) return response()->json([
            'status' => 'failed',
            'message' => 'Addon not found'
        ], 404);
        return $addon;
    }
    private function checkMeal($id)
    {
        $meal = Meal::find($id);
        if (!$meal) return response()->json([
            'status' => 'failed',
            'message' => 'Meal not found'
        ], 404);
        return $meal;
    }
    private function checkExtra($id)
    {
        $extra = Extra::find($id);
        if (!$extra) return response()->json([
            'status' => 'failed',
            'message' => 'Extra not found'
        ], 404);
        return $extra;
    }
    private function checkLocation($id)
    {
        $location = OrderLocation::find($id);
        if (!$location) return response()->json([
            'status' => 'failed',
            'message' => 'Location not found'
        ], 404);
        return $location;
    }
    private function checkDiningTable($id)
    {
        $diningtable = DiningTable::find($id);
        if (!$diningtable) return response()->json([
            'status' => 'failed',
            'message' => 'DiningTable not found'
        ], 404);
        return $diningtable;
    }
}
