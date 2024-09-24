<?php
namespace App\Traits;

trait GeneralTrait
{
    public function getCurrentLang(){
        app()->getLocale();
    }


    public function returnError($errNum, $msg)
    {
            return response()->json([
                'status' => false,
                'errNum' =>$errNum,
                'msg' => $msg
            ]);

    }

    public function returnSuccessMessage($msg="", $errNum="S0000000000")
    {
        return [
            'status' => true,
            'errNum' => $errNum,
            'msg'  =>$msg
        ];
    }

    public function returnData ($msg="",$key,$value,)
    {
        return response()->json([
                'status' => true,
                'msg '=> $msg,
                $key => $value
            ]);
    }

    public function returnCodeAccordingToInput($validator)
    {
        $input = array_keys($validator->errors()->toArray());
        $code = $this->getErrorCode($input[0]);
        return $code;
    }

    public function getErrorCode($input)
    {
        if($input == "name")
        return "E001";
        else if($input == "password")
        return "E002";
        else if($input == "phone")
        return "E003";


    }
    public function retunValidationError($code ='E001',$validator)
    {
        return $this->getErrorCode($code,$validator->errors()->first());
    }
}  