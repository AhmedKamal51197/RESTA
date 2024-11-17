<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Employee; 
use App\Models\Withdrawal; 
use App\Models\SystemBalance; 
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class WithdrawController extends Controller
{
    public function store(Request $request)
    {
        // Validate amount input
        $request->validate([
            'amount' => 'required|numeric|min:0',
        ]);

        $amount = $request->input('amount');
        $loggedInEmployeeId = auth('admin-api')->id(); 
        $employee = Employee::find($loggedInEmployeeId);

        if (!$employee) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Employee not found.',
            ], 404);
        }

        if ($employee->Role !== "admin") { 
            return response()->json([
                'status' => 'failed',
                'message' => 'You do not have permission to perform this action.',
            ], 403);
        }

        try {
            DB::transaction(function () use ($amount, $loggedInEmployeeId) {
                $balance = SystemBalance::first();

                if ($amount > $balance->balance) {
                    throw new \Exception('Insufficient balance for this withdrawal.');
                }

                Withdrawal::create([
                    'amount' => $amount,
                    'employee_id' => $loggedInEmployeeId,
                ]);

                $balance->balance -= $amount;
                $balance->save(); 
            });

            return response()->json([
                'status' => 'success',
                'message' => 'Withdrawal successful and balance updated.',
            ]);
        } catch (\Exception $e) {
            Log::error("Withdrawal error: " . $e->getMessage(), ['employee_id' => $loggedInEmployeeId]);
            return response()->json([
                'status' => 'failed',
                'message' => 'An error occurred while processing the withdrawal.',
            ], 400); 
        }
    }

    public function index()
    {
        $this->authorizeAdmin();

        $withdrawals = Withdrawal::with('employee')->get();
        $formattedWithdrawals = $withdrawals->map(function ($withdrawal) {
            return [
                'id' => $withdrawal->id,
                'employee_id' => $withdrawal->employee_id,
                'amount' => $withdrawal->amount,
                'created_at' => $withdrawal->created_at,
                'name' => $withdrawal->employee->name,
            ];
        });

        return response()->json([
            'data' => $formattedWithdrawals,
        ]);
    }

    public function getCurrentBalance()
    {
        $balanceRecord = SystemBalance::first();
        $balance = $balanceRecord ? $balanceRecord->balance : 0;

        Log::info("Current Balance: " . $balance);

        return response()->json([
            'status' => 'success',
            'balance' => $balance,
        ]);
    }

    private function authorizeAdmin()
    {
        if (!Auth::guard('admin-api')->check()) {
            throw ValidationException::withMessages([
                'role' => 'You do not have permission to perform this action.',
            ]);
        }
    }
}
