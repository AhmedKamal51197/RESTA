<?php 
namespace App\Customs\Services;

use App\Mail\VerifyEmail;
use App\Models\Customer;
use App\Models\EmailVerificationToken;
use App\Notifications\EmailVerificationNotification;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Str;

class EmailVerificationService 
{
    /**
     * Send verification link
    */
    public function sendVerificationlink($user)
    {
        Mail::to($user->email)->send(new VerifyEmail($user,$this->generateVerificationLink($user->email)));

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
            $this->sendVerificationlink($user);
            return response()->json([
                'status'=>'success',
                'message'=>'verification link sent successfully'
            ]);
        }else{
            return response()->json([
                'status'=>'failed',
                'message'=>'Customer not found'
            ]);
        }
    }
    /**
     * Check if user already verified
     */
    public function checkEmailIsVerified($user)
    {
        if($user->email_verified_at)
        {
           return  response()->json([
                'status'=>'failed',
                'message'=>'Email has already been verified'
            ]);
        }

    }
    /**
     * Verify user Email
     */
    public function verifyEmail($email,$token)
    {
        $user = Customer::where('email',$email)->first();
        if(!$user)
        {
            return response()->json([
                'status'=>'failed',
                'message'=>'customer not found',

            ]);
        }
        $this->checkEmailIsVerified($user);
        $verifiedToken = $this->verifyToken($email,$token);
        if($user->markEmailAsVerified())
        {
            if($verifiedToken instanceof EmailVerificationToken)
                $verifiedToken->delete();
            return response()->json([
                'status'=>'success',
                'message'=> 'Email has been verified successfully'
            ],200);
        }else{
            return response()->json([
                'status'=>'failed',
                'message'=>'Email verification failed , please try again later'
            ]);
        }
    }
    /**
     * Verify token
     */
    public function verifyToken($email,$token)
    {
        $token = EmailVerificationToken::where('email',$email)->where('token',$token)->first();
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
       public function generateVerificationLink($email)
       {
            $checkIfTokenExists = EmailVerificationToken::where('email',$email)->first();
            if($checkIfTokenExists) $checkIfTokenExists->delete();
            $token = Str::uuid(); 
            $url =  "http://127.0.0.1:8000/api/auth/verify-user-email?token=".$token."&email=".$email;
            $saveToken = EmailVerificationToken::create([
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
