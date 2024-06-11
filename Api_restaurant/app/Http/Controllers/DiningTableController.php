<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\DiningTable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DiningTableController extends Controller
{
    public function getAllDiningTables()
    {
        $diningTables = DiningTable::all();
        if ($diningTables->isEmpty()) {
            return response()->json(['message' => 'No dining tables found', 'status' => 'Not Found'], 404);
        }

        return response()->json(['data' => $diningTables, 'status' => 'Ok'], 200);
    }

    public function getDiningTableById($id)
    {
        $diningTable = DiningTable::find($id);
        if (!$diningTable) {
            return response()->json(['message' => 'Dining table not found', 'status' =>'Not Found'], 404);
        }

        return response()->json(['data' => $diningTable, 'status' => 'Ok'], 200);
    }

    public function addNewDiningTable(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'num' => 'required|integer',
            'size' => 'required|integer',
            'floor' => 'required|integer',
            'status' => 'required|boolean',
            'qr_code' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);
    
        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(), 'status' => 'Bad Request'], 400);
        }
    
        if (DiningTable::where('floor', $request->floor)->where('num', $request->num)->exists()) {
            return response()->json(['message' => 'Dining table already exists', 'status' => 'Conflict'], 409);
        }
    
        $data = $request->only('floor', 'size', 'num', 'status');
    
        if ($request->hasFile('qr_code')) {
            $qrCodePath = $request->file('qr_code')->store('qr_codes', 'public');
            $data['qr_code'] = $qrCodePath;
        }
    
        $newDiningTable = DiningTable::create($data);
        return response()->json(['data' => $newDiningTable, 'status' => 'Created'], 201);
    }
    

    public function updateDiningTable(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'floor' => 'integer',
            'size' => 'integer',
            'num' => 'integer',
            'status' => 'string',
            'qr_code' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',    
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(), 'status' => 'Bad Request'], 400);
        }

        $diningTable = DiningTable::find($id);
        if (!$diningTable) {
            return response()->json(['message' => 'Dining table not found', 'status' => 'Not Found'], 404);
        }

        if ($request->hasFile('qr_code')) {
            $qrCodePath = $request->file('qr_code')->store('qr_codes', 'public');
            $data['qr_code'] = $qrCodePath;
        }
        return response()->json(['data' => $diningTable, 'qr_code_url' => asset('storage/' . $diningTable->qr_code), 'status' => 'Ok'], 200);


        $diningTable->update($request->only('floor', 'size', 'num', 'status','qr_code'));
        return response()->json(['data' => $diningTable, 'status' => 'Ok'], 200);
    }

    public function deleteDiningTable($id)
    {
        $diningTable = DiningTable::find($id);
        if (!$diningTable) {
            return response()->json(['message' => 'Dining table not found', 'status' =>'Not Found'], 404);
        }

        $diningTable->delete();
        return response()->json(['message' => 'Dining table deleted successfully', 'status' => 'Ok'], 200);
    }
}
