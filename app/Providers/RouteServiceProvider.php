<?php

namespace App\Providers;

use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\Route;

class RouteServiceProvider extends ServiceProvider
{
    /**
     * The path to the "home" route for your application.
     *
     * Typically, users are redirected here after authentication.
     *
     * @var string
     */
    public const HOME = '/home';

    /**
     * Define your route model bindings, pattern filters, and other route configuration.
     */
    public function boot(): void
    {
        $this->configureRateLimiting();

        $this->routes(function () {
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/api.php'));
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/employee.php'));
            Route::middleware('web')
                ->group(base_path('routes/web.php'));
            //Category endpoints Route
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/categories.php'));
            // Meals endpoints Route 
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/meals.php'));

            // Extras endpoints Route 
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/extra.php'));
            // Dining Table endpoints Route
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/diningTable.php'));
            // order endpoints Route
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/order.php'));
            //order location Route
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/orderLocation.php'));

            //Addons endpoints Route
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/addons.php'));

            //Offers endpoints Route
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/offers.php'));
        });
    }

    /**
     * Configure the rate limiters for the application.
     */
    protected function configureRateLimiting(): void
    {
        RateLimiter::for('api', function (Request $request) {
            return Limit::perMinute(60)->by($request->user()?->id ?: $request->ip());
        });
    }
}
