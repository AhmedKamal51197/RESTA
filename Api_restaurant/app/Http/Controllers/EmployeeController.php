<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use App\Models\Employee;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Customs\Services\EmailResetAdminPasswordService;
use App\Models\ResetPasswordToken;

class EmployeeController extends Controller
{
    protected $service;
    public function __construct(EmailResetAdminPasswordService $service)
    {
        $this->service=$service;        
    }
    public function login(LoginRequest $request)
    {
        $employee = Employee::where('email',$request->email)->first();
        if($employee && !$employee->status)
        {
            return response()->json([
                'status'=>'failed',
                'message'=>'Admin Block this Account'
            ],400);
        }
        $token=auth('admin-api')->attempt($request->validated());
        if($token)
        {
            return $this->responseWithToken($token,auth('admin-api')->user());
        }else{
            return response()->json([
                'status'=>'failed',
                'message'=>'Employee not found'
            ],401);
        }
    }
    /***
     * test middleware 
     */
    public function testMiddleware(Request $req)
    {
        return response()->json([
            'status'=>'success',
            'message'=>'he/she is admin'
        ]);
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
     * add Employee
    */
    public function store(Request $request)
    {
        $datavalidated = $request->validate([
            'name'=>['required','string','min:3','max:20'],
            'email'=>['required','string','email','unique:employees,email'],
            'phone'=>['required','string','min:8','max:12'],
            'identity_card'=>['required','string','min:6','max:8','unique:employees,identity_card'],
            'is_admin'=>['required','boolean'],
            'password'=>['required','min:8','confirmed'],
            'status'=>['boolean']
        ]);
        $employee = Employee::create([
            'name'=>$datavalidated['name'],
            'email'=>$datavalidated['email'],
            'phone'=>$datavalidated['phone'],
            'identity_card'=>$datavalidated['identity_card'],
            'is_admin'=>$datavalidated['is_admin'],
            'password'=>Hash::make($datavalidated['password']),
            'status'=>$datavalidated['status']
        ]);
        if($employee)
        {

            return response()->json([
                'request_status'=>'success',
                'data'=>$employee
            ],200);
        }
        else{
            return response()->json([
                'request_status'=>'failed',
                'message'=>'Internal server error'
            ],400);
        }

    }
    public function show($id)
    {
        try{
            $employee = Employee::findOrFail($id);
            return response()->json([
                'status'=>'success',
                'data'=>$employee
            ],200);

        }catch(ModelNotFoundException $e){
            return response()->json([
                'status'=>'failed',
                'message'=>'Employee not Found'
            ],404);
        }
    }

    public function index()
    {
        $perPage=12;
        $employees = Employee::paginate($perPage);
        if($employees->isEmpty())
        {
            return response()->json([
                'status'=>'failed',
                'message'=>'No employees Found'
            ],404);    
        }
        $pagination = [
            'total'=>$employees->total(),
            'per_page'=>$employees->perPage(),
            'current_page'=>$employees->currentPage(),
            'last_page'=>$employees->lastPage()
        ];
        return response()->json([
            'status'=>'success',
            'data'=>$employees->items(),
            'pagination'=>$pagination
        ],200);
    }

    public function update(Request $request ,$id)
    {
        try{

            $employee = Employee::findOrFail($id);
            $vlaidatedData = $request->validate([
                'name'=>['string','min:3','max:20'],
                'email'=>['string','email','unique:employees,email,'.$employee->id], //'unique:employees,email,'.$employee->id to exclude account itself to donot make confilct if it duplicate with same email
                'phone'=>['string','min:8','max:12'],
                'identity_card'=>['string','min:6','max:8','unique:employees,identity_card,'.$id],//same thing like email
                'is_admin'=>['boolean'],
                'password'=>['min:8','confirmed'],
                'status'=>['boolean']
            ]);
           foreach($vlaidatedData as $key=>$value)
           {
            // dd($value);
            // dd($key);

                if(isset($vlaidatedData[$key]))
                {
                     $employee->$key=$value;   
                }
           }
           $employee->save();
           return response()->json([
            'status'=>'success',
            'updated employee ' =>$employee
           ],200);
        }catch(ModelNotFoundException $e)
        {
                return response()->json([
                    'status'=>'failed',
                    'message'=>'employee not found']
                    ,404);
        }
        
        
    }

    public function destroy( $id)
    {
        try{
            $employee = Employee::findOrFail($id);
            $employee->delete();
            return response()->json([
                'status'=>'success',
                'message'=>'Account Deleted done'
            ],200);
        }catch (ModelNotFoundException $e)
        {
            return response()->json([
                'status'=>'failed',
                'message'=>'Empolyee not found'
            ],404);
        }
    }


    /**
     * Forget Password 
    */
    public function forogtPassword(Request $request)
    {
        $vlaidatedData = $request->validate([
            'email'=>['required','email']
        ]);
        $user = Employee::where('email',$vlaidatedData['email'])->first();
        if(!$user)
        {
            return response()->json([
                'status'=>'failed',
                'message'=>'User not found'
            ],404);
        }
        $this->service->sendResetlink($user);
        return response()->json([
            'status'=>'success',
            'message'=>'Reset Link send successfully to your email'
        ],200);
    }
    /**
     * Check Email & Token 
    */
    public function checkResetToken(Request $request)
    {
        $email = $request->email;
        $token = $request->token;
        // return response()->json(['aya 7aga']);
        $verifiedResult=$this->service->verifyEmail($email,$token);
        // dd($verifiedResult);
        if($verifiedResult instanceof ResetPasswordToken)
        {
            return response()->json([
                'status'=>'success',
                'message'=>'Email & token verified successfully you can now reset your password',
                'token'=>$token,
                'email'=>$email
            ],200);
        }
        return $verifiedResult;
    }

    /**
     * Reset password
    */
    public function resetPassword(Request $request)
    {
        $vlaidatedData = $request->validate([
            'email'=>['required','email'],
            'token'=>['required'],
            'new_password'=>['required','min:8','confirmed']
        ]);
        $user = Employee::where('email',$vlaidatedData['email'])->first();
        $verifiedResult = $this->service->verifyEmail($vlaidatedData['email'],$vlaidatedData['token']);
        if ($verifiedResult instanceof ResetPasswordToken)
        {
            $user->password=Hash::make($vlaidatedData['new_password']);
            $user->save();
            return response()->json([
                'status'=>'success',
                'message'=>'Password reset Successfully'
            ],200);
        }
        return $verifiedResult;
    }
}
