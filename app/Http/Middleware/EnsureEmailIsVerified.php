<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureEmailIsVerified
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // retrieve the authenticated user
        $user = auth('api')->user();

        // check if the user is authenticated and his email is verified 
        if($user && !$user->customer->hasVerifiedEmail())
        {
            return response()->json([
                'status'=>'failed',
                'message'=>'Your email address is not verified',
            ],403);
        }
        return $next($request);
    }
}
