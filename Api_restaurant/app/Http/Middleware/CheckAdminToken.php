<?php

namespace App\Http\Middleware;

use App\Traits\GeneralTrait;
use Closure;
use Illuminate\Http\Request;
use PHPOpenSourceSaver\JWTAuth\Exceptions\TokenExpiredException;
use PHPOpenSourceSaver\JWTAuth\Exceptions\TokenInvalidException;
use Symfony\Component\HttpFoundation\Response;
use Tymon\JWTAuth\Exceptions\JWTException;

class CheckAdminToken
{
    use GeneralTrait;
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        try{
            $user=auth('admin-api')->user();
            dd($user);
                if(!$user || !$user->is_admin)
                {
                    return response()->json([
                        'status'=>'falied',
                        'message'=>'Unauthorized',
                    ]);
                }
        }catch(JWTException $e)
        {
            return response()->json(['status'=>'failed',
            'error'=>'Invalid Token'
        ],401);
        }
       
        return $next($request);
    }
}
