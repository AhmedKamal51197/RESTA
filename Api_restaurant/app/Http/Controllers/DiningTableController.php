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
            return response()->json(['message' => 'Dining table not found', 'status' => 'Not Found'], 404);
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
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(), 'status' => 'Bad Request'], 400);
        }

        if (DiningTable::where('floor', $request->floor)->where('num', $request->num)->exists()) {
            return response()->json(['message' => 'Dining table already exists', 'status' => 'Conflict'], 409);
        }

        $data = $request->only('floor', 'size', 'num', 'status');
        $newDiningTable = DiningTable::create($data);

        // Generate QR code for the new dining table
        $qrCodePath = $newDiningTable->generateQrCode();
        
        if (!$qrCodePath) {
            return response()->json(['message' => 'Failed to generate QR code', 'status' => 'Internal Server Error'], 500);
        }
        
        $newDiningTable->qr_code = $qrCodePath;
        $newDiningTable->save();

        return response()->json(['data' => $newDiningTable, 'qr_code_url' => asset($qrCodePath), 'status' => 'Created'], 201);
    }


    public function updateDiningTable(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'floor' => 'integer',
            'size' => 'integer',
            'num' => 'integer',
            'status' => 'string',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(), 'status' => 'Bad Request'], 400);
        }

        $diningTable = DiningTable::find($id);
        if (!$diningTable) {
            return response()->json(['message' => 'Dining table not found', 'status' => 'Not Found'], 404);
        }

        $diningTable->update($request->only('floor', 'size', 'num', 'status'));
        return response()->json(['data' => $diningTable, 'status' => 'Ok'], 200);
    }

    public function deleteDiningTable($id)
    {
        $diningTable = DiningTable::find($id);
        if (!$diningTable) {
            return response()->json(['message' => 'Dining table not found', 'status' => 'Not Found'], 404);
        }

        $diningTable->delete();
        return response()->json(['message' => 'Dining table deleted successfully', 'status' => 'Ok'], 200);
    }
}
