<?php 
namespace App\Customs\Services;

use App\Mail\ResetEmail;
use App\Models\Customer;
use App\Models\Employee;
use App\Models\ResetPasswordToken;
// use App\Notifications\EmailVerificationNotification;
use Illuminate\Support\Facades\Mail;
// use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Str;

class EmailResetPasswordService 
{
    /**
     * Send verification link
    */
    public function sendResetlink($user)
    {
        Mail::to($user->email)->send(new ResetEmail($user,$this->generateResetLink($user->email)));

      //  Notification::send($user, new EmailVerificationNotification($this->generateVerificationLink($user->email)));
    }
    /**
     * Resend link with token
     */
    public function resendLink($email)
    {
        $user = Customer::where('email',$email)->first();
        if($user)
        {
            $this->sendResetlink($user);
            return response()->json([
                'status'=>'success',
                'message'=>'ResetPassword link sent successfully'
            ]);
        }else{
            return response()->json([
                'status'=>'failed',
                'message'=>'User not found'
            ]);
        }
    }
 
    /**
     * Verify user Email
     */
    public function verifyEmail($email,$token)
    {
        $user = Customer::where('email',$email)->first();
        if(!$user) return response()->json([
            'status'=>'failed',
            'message'=>'User not found'
        ],400);
        else 
            $resetToken = $this->verifyToken($email,$token);
            
            return $resetToken; 
    }
    /**
     * Verify token
     */
    public function verifyToken($email,$token)
    {
        $token = ResetPasswordToken::where('email',$email)->where('token',$token)->first();
        if($token)
        {
            if($token->expired_at>=now())
            {
                return $token;
            }else{
                $token->delete();
                return response()->json([
                    'status'=>'failed',
                    'message'=>'Token expired',
                ],400);
            }
        }
        else
        {
           return response()->json([
                'status'=>'failed',
                'message'=>'Invalid token'
            ]);
            
        }
    }   
    /**
     * Generate verification Link
     */
       public function generateResetLink($email)
       {
            $checkIfTokenExists = ResetPasswordToken::where('email',$email)->first();
            if($checkIfTokenExists) $checkIfTokenExists->delete();
            $token = Str::uuid(); 
            $url =  "http://127.0.0.1:8000/api/auth/reset-password-form?token=".$token."&email=".$email;
            $saveToken = ResetPasswordToken::create([
                "email"=>$email,
                "token"=>$token,
                "expired_at"=>now()->addMinutes(60),
            ]);
            if($saveToken)
            {
                return $url;
            }
       }

}
