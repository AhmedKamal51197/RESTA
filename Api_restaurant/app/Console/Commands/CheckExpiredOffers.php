<?php

namespace App\Console\Commands;

use App\Models\ExpiredOffer;
use App\Models\Offer;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
class CheckExpiredOffers extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'offers:check-expired';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Check for expired offers and update their status';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $now = Carbon::now();

        // Find expired offers using Eloquent
        $expiredOffers = ExpiredOffer::where('expired_Date', '<=', $now)->get();

        if ($expiredOffers->isEmpty()) {
            $this->info('No expired offers found.');
        }
        foreach ($expiredOffers as $expiredOffer) {
            // Update the offer status to 0
            $offer = Offer::find($expiredOffer->offer_id);
            if ($offer) {
                $offer->update(['status' => 'inactive']);
                $this->info($offer->status);
            }

            // Delete the record from expired_offers
            $expiredOffer->delete();
       }

       $this->info('Expired offers have been processed.');
       return 0;
   
    }
}
