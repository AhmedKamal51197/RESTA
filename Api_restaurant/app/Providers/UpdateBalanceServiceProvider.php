<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Models\Transaction;
use App\Models\Withdrawal;
use App\Models\SystemBalance;

class UpdateBalanceServiceProvider extends ServiceProvider
{
    public function register()
    {
        //
    }

    public function boot()
    {
        $totalTransactions = Transaction::sum('amount');
        $totalWithdrawals = Withdrawal::sum('amount');
        $balance = $totalTransactions - $totalWithdrawals;

        $balanceRecord = SystemBalance::first();
        if ($balanceRecord) {
            $balanceRecord->update(['balance' => $balance]);
        } else {
            SystemBalance::create(['balance' => $balance]);
        }
    }
}

