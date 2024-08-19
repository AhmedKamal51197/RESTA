<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;

class CheckRolePermission
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        try {
            $user = auth('admin-api')->user();
            if($user->Role==='casher')
            {
                return response()->json([
                    'status'=>'failed',
                    'message'=>'unuthoraized you are not super admin'
                ]); 
            }
            else if($user->Role==='chef')
            {
                return response()->json([
                    'status'=>'failed',
                    'message'=>'unuthoraized you are not super admin'
                ]); 
            }
        } catch (TokenInvalidException $e)
        {
            return response()->json([
                'status'=>'falied',
                'message'=>$e->getMessage(),
            ]);
        }
        catch (TokenExpiredException $e)
        {
            return response()->json([
                'status'=>'falied',
                'message'=>'Token has expired',
            ]);
        }
        catch(JWTException $e)
        {
            return response()->json(['status'=>'failed',
            'error'=>'There is a problem with your token'],401);
        }
        return $next($request);
    }
   
}
