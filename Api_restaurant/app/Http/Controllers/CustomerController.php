<?php

namespace App\Http\Controllers;

use App\Customs\Services\EmailResetPasswordService;
use App\Customs\Services\EmailVerificationService;
use App\Models\Customer;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegistrationRequest;
use App\Http\Requests\ResendEmailVerificationLinkRequest;
use App\Http\Requests\VerifyEmailRequest;
use App\Models\ResetPasswordToken;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use PHPOpenSourceSaver\JWTAuth\Claims\Custom;

use function PHPUnit\Framework\isEmpty;

class CustomerController extends Controller
{
    //
    //use Notifiable;
    protected $service, $reset_service;
    /**
     *test auth middleware  
     */
    public function test(Request $req)
    {
        return response()->json(["message" => "success"]);
    }
    public function __construct(EmailVerificationService $service, EmailResetPasswordService $reset_service)
    {
        $this->reset_service = $reset_service;
        $this->service = $service;
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
        if ($customer) {
            // dd($customer instanceof \PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject);

            $this->service->sendVerificationlink($customer);
            // $token = auth('api')->login($customer);
            return response()->json([
                'status' => 'success',
                'message' => 'Registration successful, Please check your email to verify your address ',
            ], 201);  //$this->responseWithToken($token,$customer);
        } else {
            return response()->json([
                'status' => 'failed',
                'message' => 'An error occure while trying to create user'
            ], 500);
        }
    }
    /**
     * get token response
     */
    public function responseWithToken($token, $user)
    {
        return response()->json([
            'status' => 'success',
            'customer' => $user,
            'access_token' => $token,
            'type' => 'bearer'
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
     * get token for verification 
     */
    public function getToken(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'message' => 'you can verify your email now',
            'token' => $request->token,
            'email' => $request->email
        ]);
    }
    /**
     * Verify Customer email
     */
    public function verifyCustomerEmail(VerifyEmailRequest $request)
    {
        //dd($request->email,$request->token);
        return $this->service->verifyEmail($request->email, $request->token);
    }

    public function login(LoginRequest $request)
    {
        $dataValidated = $request->validated();
        // dd($dataValidated);
        $customer = Customer::where('email', $dataValidated['email'])->first();
        if ($customer) {
            if (!$customer->status) {
                return response()->json([
                    'status' => 'failed',
                    'message' => 'Admin blocked this account'
                ], 400);
            }
        }

        $token = auth('api')->attempt($dataValidated);
        // dd($token);
        if (!$token) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Invalid email or password or you must verify your email first'
            ], 401);
        } else {

            $verify = auth('api')->user()->email_verified_at;
            if ($token && $verify) {
                return $this->responseWithToken($token, auth('api')->user());
            } else {
                return response()->json([
                    'status' => 'failed',
                    'message' => 'Invalid email or password or you must verify your email first'
                ], 401);
            }
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
            'name' => $request->validated('name'),
            'email' => $request->validated('email'),
            'phone' => $request->validated('phone'),
            'password' => Hash::make($request->validated('password'))
        ]);
        if ($customer) {
            $this->service->sendVerificationlink($customer);
            return response()->json([
                'status' => 'success',
                'message' => 'Added done please check your email we sent verification link to you',
                'data' => $customer
            ], 200);
        }
        return response()->json([
            'status' => 'failed',
            'message' => 'internal server error'
        ], 500);
    }
    public function destroy($id)
    {
        $customer = Customer::find($id);
        if (!$customer) {
            return response()->json([
                'status' => 'falied',
                'message' => 'Customer account not found'
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'message' => 'deleted done'
        ], 200);
    }
    //update customers data  
    public function update(Request $request, $id = null)
    {
        if ($id) {
            $updatedCustomer = Customer::find($id);
            if (!$updatedCustomer) return response()->json([
                'status' => 'failed',
                'message' => 'This account not found'
            ], 404);
        } else {


            $updatedCustomer = auth('api')->user();
            //  dd($updatedCustomer);    
        }
        $data = $request->validate([
            'name' => ['required', 'string', 'min:3', 'max:20'],
            'email' => ['required', 'unique:customers,email,' . $updatedCustomer->id],
            'phone' => ['required', 'string', 'min:8', 'max:12'],
            'status' => ['required', 'in:active,inactive']
        ]);
        // dd($request->validated());
        $updatedCustomer->update([
            'name' => $data['name'],
            'email' => $data['email'],
            'phone' => $data['phone'],
            'status' => $data['status']
        ]);
        $updatedCustomer->email_verified_at = null;
        $updatedCustomer->save();
        return response()->json([
            'status' => 'success',
            'message' => 'updated done',
            'data' => $updatedCustomer
        ]);
    }
    // get all customers
    public function index()
    {
        $customers = Customer::all();
        if ($customers->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No customers found'
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'data' => $customers
        ]);
    }
    public function show($id)
    {
        $customer = Customer::find($id);
        if (!$customer) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Customer not found'
            ], 404);
        }
        return response()->json([
            'status' => 'sucess',
            'data' => $customer
        ]);
    }


    /**
     * Forgot password
     */
    public function forgotPassword(Request $request)
    {

        $validatedData = $request->validate([
            'email' => ['required', 'email:filter'],

        ]);
        // dd($request)
        //dd($data['email']);
        $email = $validatedData['email'];
        $user = Customer::where('email', $email)->first();
        if (!$user) return response()->json(['status' => 'failed', 'message' => 'Invalid email'], 400);
        $this->reset_service->sendResetlink($user);
        return response()->json([
            'status' => 'success',
            'message' => 'please check your email to reset your password'
        ], 200);
    }



    /**
     * check Token 
     */
    public function showResetPasswordForm(Request $request)
    {

        $email = $request->email;
        $token = $request->token;

        $verifiedResult = $this->reset_service->verifyEmail($email, $token);
        if ($verifiedResult instanceof ResetPasswordToken) {
            return response()->json([
                'status' => 'success',
                'message' => 'Token verified, you can now reset password ',
                'token' => $token,
                'email' => $email

            ], 200);
        }
        return  $verifiedResult;
    }
    /**
     * Reset password  
     */
    public function resetPassword(Request $request)
    {

        $dataValidated = $request->validate([
            'email' => ['required', 'email', 'exists:customers,email'],
            'token' => ['required'],
            'new_password' => ['required', 'min:8', 'confirmed'],
        ]);
        $token = $dataValidated['token'];
        $email = $dataValidated['email'];
        $verifyTokenResult = $this->reset_service->verifyEmail($email, $token);
        if ($verifyTokenResult instanceof ResetPasswordToken) {

            $newPassword = $dataValidated['new_password'];
            $customer = Customer::where('email', $email)->first();
            if (!$customer) return response()->json(['status' => 'failed', 'message' => 'Account not found'], 404);

            $customer->password = Hash::make($newPassword);
            $customer->save();

            return response()->json([
                'status' => 'success',
                'message' => 'password Reset succeefully'
            ], 200);
        }
        return $verifyTokenResult;
    }
    // for dashboard 
    public function filterByName($name)
    {
        $customer = Customer::where('name', $name)->get();
        if ($customer->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => "No customers existing with name : $name"
            ], 400);
        }
        return response()->json([
            'status' => 'success',
            'data' => $customer
        ], 200);
    }
}
