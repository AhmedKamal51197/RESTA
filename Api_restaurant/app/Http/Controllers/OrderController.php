<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;

class OrderController extends Controller
{

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
        if ($order->status == 1) {
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

    public function store(Request $request)
    {
        $validatedData = $request->validate([

            'meal_id' => ['integer'],
            'meal_quantity' => ['required_with:meal_id', 'integer'],
            'meal_cost' => ['required_with:meal_id', 'numeric'],

        ]);
    }
}
