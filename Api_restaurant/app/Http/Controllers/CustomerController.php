<?php

namespace App\Http\Controllers;

use App\Customs\Services\EmailVerificationService;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Notifications\Notifiable;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegistrationRequest;
use App\Http\Requests\ResendEmailVerificationLinkRequest;
use App\Http\Requests\VerifyEmailRequest;
use App\Rules\ValidEmail;
use Illuminate\Support\Facades\Hash;

class CustomerController extends Controller
{
    //
    //use Notifiable;
    protected $service;
    /**
     *test auth middleware  
     */
    public function test(Request $req)
    {
        return response()->json(["message"=>"success"]);
    }
    public function __construct(EmailVerificationService $service)
    {
        $this->service=$service;
    }
    public function register(RegistrationRequest $request)
    {
        // dd($request->validated('name'));
        $customer = Customer::create([
            // $request->validated()

            'name' => $request->validated('name'),
            'email' => $request->validated('email'),
            'password' => Hash::make($request->validated('password')),
            'phone' => $request->validated('phone'),
        ]);
        // dd($customer);
        if($customer)
        {
           // dd($customer instanceof \PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject);

            $this->service->sendVerificationlink($customer);
           // $token = auth('api')->login($customer);
            return response()->json([
                'status'=>'success',
                'message' => 'Registration successful, Please check your email to verify your address ',
            ],201);  //$this->responseWithToken($token,$customer);
        }
        else{
            return response()->json([
                'status' =>'failed',
                'message' =>'An error occure while trying to create user'
            ],500);
        }

    }
    /**
     * get token response
     */
    public function responseWithToken($token,$user)
    {
        return response()->json([
            'status'=>'success',
            'customer'=>$user,
            'access_token'=>$token,
            'type'=>'bearer'
        ]);
    }
    /**
     * Resend email verification link 
     */
    public function resendVerificationEmailLink(ResendEmailVerificationLinkRequest $request)
    {
        return $this->service->resendLink($request->email);
    }
   
    /**
     * Verify Customer email
     */
    public function verifyCustomerEmail(VerifyEmailRequest $request)
    {
        //dd($request->email,$request->token);
        return $this->service->verifyEmail($request->email,$request->token);
    }
    // public function verifyEmail(Request $request)
    // {

    // }
    public function login(LoginRequest $request)
    {
       
        $token = auth('api')->attempt($request->validated());
        $verify= auth('api')->user()->email_verified_at;
        // dd($verify);
        if($token && $verify)
        {
            return $this->responseWithToken($token,auth('api')->user());
        }else {
            return response()->json([
                'status'=>'failed',
                'message' => 'Invalid email or password or you must verify your email first'
            ], 401);
        }
    }
    public function logout()
    {
        // Auth::logout();
        //havenot implemented yet
        
        Auth::logout('api');
        return response()->json(['message' => 'Logout successful'], 200);
    }

    public function addCustomer(RegistrationRequest $request)
    {
        $customer = Customer::create([
            'name'=>$request->validated('name'),
            'email'=>$request->validated('email'),
            'phone'=>$request->validated('phone'),
            'password'=>Hash::make($request->validated('password'))
        ]);
        if($customer)
        {
            $this->service->sendVerificationlink($customer);
            return response()->json([
                'status'=>'success',
                'message'=>'Added done please check your email we sent verification link to you',
                'data'=>$customer
            ],200);
        }
        return response()->json([
            'status'=>'failed',
            'message'=>'internal server error'
        ],500);
       
    }
    public function destroy($id)
    {
        $customer = Customer::find($id);
        if(!$customer)
        {
               return response()->json([
                'status'=>'falied',
                'message'=>'Customer account not found'
               ],404); 
        }
        return response()->json([
            'status'=>'success',
            'message'=>'deleted done'
        ],200);
    }
    //update customers data  
    public function update(Request $request ,$id=null)
    {
        if($id)
        {
            $updatedCustomer = Customer::find($id);
            if(!$updatedCustomer) return response()->json(['status'=>'failed',
            'message'=>'This account not found'],404);

        }
        else{

            // here customer who is authenticated can update his own profile
            // I use auth('api')->user()  => this return authenticated customer and it's return as Authenticatabl instance
            // so I used additional ->customer to return instance as a customer and can do update() method 
            // casue update method can only work with Eloquent object
            $updatedCustomer = auth('api')->user()->customer;
        }
        $request->validate([
            'name'=>['required','string','min:3','max:20'],
            'email'=>['required','unique:customers,email,'.$updatedCustomer->id,new ValidEmail()],
            'phone' =>['required','string','min:12','max:25']

        ]);
        $updatedCustomer->update($request->validated());
        return response()->json([
            'status'=>'success',
            'message'=>'updated done',
            'data'=>$updatedCustomer
        ]);
    }
    // get all customers
    public function index()
    {
        $customers = Customer::all();
        if($customers->isEmpty())
        {
            return response()->json([
                'status'=>'failed',
                'message'=>'No customers found'
            ],404);
        }
        return response()->json([
            'status'=>'success',
            'data'=>$customers
        ]);
    }
    public function show($id)
    {
        $customer = Customer::find($id);
        if(!$customer)
        {
            return response()->json([
                'status'=>'failed',
                'message'=>'Customer not found'
            ],404);
        }
        return response()->json([
            'status'=>'sucess',
            'data'=>$customer
        ]);
    }


    // public function 
    
}
