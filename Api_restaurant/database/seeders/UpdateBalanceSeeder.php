<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Transaction;
use App\Models\Withdrawal;
use App\Models\SystemBalance;

class UpdateBalanceSeeder extends Seeder
{
    public function run()
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

