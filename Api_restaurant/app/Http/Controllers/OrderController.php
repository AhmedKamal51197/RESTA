<?php

namespace App\Http\Controllers;

use App\Customs\Services\FatoorahServices;
use App\Http\Requests\OrderRequest;
use App\Models\Addon;
use App\Models\Customer;
use App\Models\DiningTable;
use App\Models\Extra;
use App\Models\Meal;
use App\Models\Order;
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
// use function PHPSTORM_META\map;

class OrderController extends Controller
{
    private $fatoorahServices;
    public function __construct(FatoorahServices $fatoorahServices)
    {
        $this->fatoorahServices = $fatoorahServices;
    }

    public function index()
    {
        $perPage = 12;
        $orders = Order::with(['customer', 'orderAddons.addon', 'orderMeals.meal', 'orderExtras.extra'])
            ->paginate($perPage);

        if ($orders->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No orders have placed yet!'
            ], 404);
        }
        //  dd($orders[0]->status);
        foreach ($orders as $order) {
            if ($order->status === 1) {
                $order->status = 'Processing';
            } else if ($order->status == 2) {
                $order->status = 'Out of delivery';
            } else if ($order->status == 3) {
                $order->status = 'Done';
            } else if ($order->status == 4) {
                $order->status = 'Cancled';
            }
        }
        $pagination = [
            'total' => $orders->total(),
            'per_page' => $orders->perPage(),
            'current_page' => $orders->currentPage(),
            'last_page' => $orders->lastPage()
        ];
        return response()->json([
            'status' => 'success',
            'data' => $orders->items(),
            'pagination' => $pagination
        ], 200);
    }
    public function get_order_meals($id)
    {
        $order_meals = OrderMeal::where('order_id', $id)->paginate(12);

        if ($order_meals->isEmpty()) return response()->json([
            'status' => 'failed',
            'message' => 'No meals found',
        ], 404);
        foreach ($order_meals as $order_meal) {

            $meal = Meal::find($order_meal->meal_id);
            $order_meal->meal_name = $meal ? $meal->name : null;
        }
        $pagination = [
            'total' => $order_meals->total(),
            'per_page' => $order_meals->perPage(),
            'current_page' => $order_meals->currentPage(),
            'last_page' => $order_meals->lastPage()
        ];
        return response()->json([
            'status' => 'success',
            'data' => $order_meals->items(),
            'pagination' => $pagination
        ], 200);
    }


    public function get_order_addons($id)
    {
        $order_addons = OrderAddon::where('order_id', $id)->paginate(12);
        if ($order_addons->isEmpty()) return response()->json([
            'status' => 'failed',
            'message' => 'No addons found',
        ], 404);
        foreach ($order_addons as $order_addon) {

            $addon = Addon::find($order_addon->addon_id);


            $order_addon->addon_name = $addon ? $addon->name : null;
        }
        $pagination = [
            'total' => $order_addons->total(),
            'per_page' => $order_addons->perPage(),
            'current_page' => $order_addons->currentPage(),
            'last_page' => $order_addons->lastPage()
        ];
        return response()->json([
            'status' => 'success',
            'data' => $order_addons->items(),
            'pagination' => $pagination
        ], 200);
    }
    public function get_order_extras($id)
    {
        $orders = OrderExtra::where('order_id', $id)->paginate(12);

        if ($orders->isEmpty()) return response()->json([
            'status' => 'failed',
            'message' => 'No Extras found'
        ], 404);
        foreach ($orders as $order) {
            $extra = Extra::find($order->extra_id);
            $order->extra_name = $extra->name;
        }
        $pagination = [
            'total' => $orders->total(),
            'per_page' => $orders->perPage(),
            'current_page' => $orders->currentPage(),
            'last_page' => $orders->lastPage()
        ];
        return response()->json([
            'status' => 'success',
            'data' => $orders->items(),
            'pagination' => $pagination
        ], 200);
    }
    public function show($id)
    {
        $order = Order::with(['customer', 'orderAddons.addon', 'orderMeals.meal', 'orderExtras.extra'])->find($id);
        if (!$order) return response()->json([
            'status' => 'failed',
            'message' => 'No Order Found'
        ], 404);
        if ($order->status === 1) {
            $order->status = 'Processing';
        } else if ($order->status == 2) {
            $order->status = 'Out of delivery';
        } else if ($order->status == 3) {
            $order->status = 'Done';
        } else if ($order->status == 4) {
            $order->status = 'Cancled';
        }

        return response()->json([
            'status' => 'success',
            'data' => $order
        ], 200);
    }
    // order with online payment
    public function payOrder(OrderRequest $request)
    {


        $validatedData = $request->validated();
        $mealIds = $validatedData['meal_ids'] ?? [];
        $addonIds = $validatedData['addon_ids'] ?? [];
        $extraIds = $validatedData['extra_ids'] ?? [];
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
            ]);
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
            // return response()->json([
            //     'status' => 'success',
            //     'message' => 'Order created successfully'
            // ], 201);
            $data = [
                'CustomerName' => auth('api')->user()->name,
                'NotificationOption' => 'LNK',
                'InvoiceValue' => $validatedData['total_cost'],
                'CustomerEmail' => auth('api')->user()->email,
                'CallBackUrl' => env('success_url'),
                'ErrorUrl' => env('error_url'),
                'Language' => 'en',
                'DisplayCurrencyIso' => 'OMR'
            ];
            // dd($order->total_cost);

            $data = $this->fatoorahServices->sendPayment($data);
            // dd($data);
            $transaction = Transaction::create([
                'customer_id' => auth('api')->id(),
                'order_id' => $order->id,
                'amount' => $order->total_cost,
                'InvoiceId' => $data['Data']['InvoiceId'],
            ]);
            return response()->json([
                'status' => 'success',
                'Transaction_id' => $transaction->id,
                'Invoice Data' => $data
            ], 200);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'failed',
                'message' => $e->getMessage()
            ], 400);
        }
    }
    public function paymentCallBack(Request $request)
    {
        $data = [
            'Key' => $request->paymentId,
            'KeyType' => 'paymentId'
        ];
        $paymentStatus = $this->fatoorahServices->getPaymentStatus($data);

        //dd($paymentStatus);
        //$email=$paymentStatus['Data']['CustomerEmail'];
        // $transaction=Transaction::with(['customer', 'order'])
        // ->whereHas('customer', function ($query) use ($email) {
        //     $query->where('email', $email);
        // })
        //->first();
        // dd($transaction);
        // $paymentStatus['Data']['InvoiceId'];
        // dd($paymentStatus['Data']['InvoiceId']);
        if ($paymentStatus['IsSuccess']) {
            $invoiceId = $paymentStatus['Data']['InvoiceId'];
            $transaction = Transaction::where('InvoiceId', $invoiceId)->first();
            //dd($invoiceId);
            $transaction->payment_method = 'VisaMasterCard';
            $transaction->save();
            return response()->json([
                'status' => 'success',
                'message' => 'Payment was successful!'
            ], 200);
        }
    }
    public function callbackError()
    {
        return response()->json([
            'status' => 'failed',
            'message' => 'Error occured in payment please try again'
        ], 404);
    }
    // order without payment online 
    public function store(OrderRequest $request)
    {

        $validatedData = $request->validated();
        $mealIds = $validatedData['meal_ids'] ?? [];
        $addonIds = $validatedData['addon_ids'] ?? [];
        $extraIds = $validatedData['extra_ids'] ?? [];
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
            ]);
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

        $orders = Order::with(['customer', 'orderAddons.addon', 'orderMeals.meal', 'orderExtras.extra'])->where('customer_id', $userId)->paginate(12);
        //  dd($orders->isEmpty());
        if ($orders->isEmpty()) return response()->json([
            'status' => 'failed',
            'message' => 'No orders are made with that Customer'
        ], 404);
        $pagination = [
            'total' => $orders->total(),
            'per_page' => $orders->perPage(),
            'current_page' => $orders->currentPage(),
            'last_page' => $orders->lastPage()
        ];
        return response()->json([
            'status' => 'success',
            'data' => $orders->items(),
            'pagination' => $pagination
        ], 200);
    }

    public function getAllTransactions()
    {
        $transactions = Transaction::paginate(20);

        $pagination = [
            'total' => $transactions->total(),
            'per_page' => $transactions->perPage(),
            'current_page' => $transactions->currentPage(),
            'last_page' => $transactions->lastPage()
        ];
        if ($transactions->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No transaction found'
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'Transactions' => $transactions->items(),
            'pagination' => $pagination
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
        $sales = Order::whereBetween('created_at', [$startDate, $endDate])->sum('total_cost');
        if (!$sales) {
            return response()->json([
                'status' => 'failed',
                'message' => 'sales not found'
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'sales' => $sales
        ], 200);
    }
    //Most Popular Items NOT EMPLEMENT YET 
    public function MostPopularItems()
    {
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
