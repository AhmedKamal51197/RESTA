<?php

namespace App\Http\Middleware;

use App\Traits\GeneralTrait;
use Closure;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
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
    // this middleware for rule for superAdmin
    public function handle(Request $request, Closure $next): Response
    {

        try{
            $user=auth('admin-api')->user();
                if(!$user || $user->Role!=='admin')
                {
                    throw new TokenInvalidException('You are not Superadmin');
                    
                }
        }
        catch (TokenInvalidException $e)
        {
            return response()->json([
                'status'=>'falied',
                'message'=>$e->getMessage(),
            ],401);
        }
        catch (TokenExpiredException $e)
        {
            return response()->json([
                'status'=>'falied',
                'message'=>'Token has expired',
            ],401);
        }
        catch(JWTException $e)
        {
            return response()->json(['status'=>'failed',
            'error'=>'There is a problem with your token'],401);
        }
       
        return $next($request);
    }
}
