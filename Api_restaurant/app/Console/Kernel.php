<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use App\Http\Controllers\OfferController;


class Kernel extends ConsoleKernel
{
    /**
     * Define the application's command schedule.
     */
    // protected function schedule(Schedule $schedule): void
    // {
    //     $schedule->command('offers:check-expired')->everyMinute();

    // }
    protected function schedule(Schedule $schedule)
    {
        $schedule->call(function () {
            app(OfferController::class)->updateExpiredOffers();
        })->everyMinute(); 
    }
    
    /**
     * Register the commands for the application.
     */
    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
