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
            return response()->json(['message' => 'No dining tables found', 'status' => 'failed'], 404);
        }
    
        $diningTablesWithUrl = $diningTables->map(function ($diningTable) {
            $diningTable->qr_code_link = url('http://localhost:3000/customer/menu?number=' . $diningTable->num . '&floor=' . $diningTable->floor);
            return $diningTable;
        });
    
        return response()->json(['data' => $diningTablesWithUrl, 'status' => 'success'], 200);
    }
    
    public function getDiningTableById($id)
    {
        $diningTable = DiningTable::find($id);
        if (!$diningTable) {
            return response()->json(['message' => 'Dining table not found', 'status' => 'failed'], 404);
        }
    
        $diningTable->qr_code_link = url('http://localhost:3000/customer/menu?number=' . $diningTable->num . '&floor=' . $diningTable->floor);
    
        return response()->json(['data' => $diningTable, 'status' => 'success'], 200);
    }
    

    
    public function addNewDiningTable(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'floor' => ['required', 'integer', 'min:1'],
            'size' => ['required', 'integer', 'min:1'],
            'num' => ['required', 'integer', 'min:1'],
            'status' => 'required|boolean',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(), 'status' => 'failed'], 400);
        }

        if (DiningTable::where('floor', $request->floor)->where('num', $request->num)->exists()) {
            return response()->json(['message' => 'Dining table already exists', 'status' => 'failed'], 409);
        }

        $data = $request->only('floor', 'size', 'num', 'status');
        $newDiningTable = DiningTable::create($data);

        return response()->json([
            'message' => 'Dining table added successfully',
            'status' => 'success'
        ], 201);
    }


    public function updateDiningTable(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'floor' => ['integer','min:1'],
            'size' => ['integer','min:1'],
            'num' => ['integer','min:1'],
            'status' => 'boolean',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors(), 'status' => 'failed'], 400);
        }

        $diningTable = DiningTable::find($id);
        if (!$diningTable) {
            return response()->json(['message' => 'Dining table not found', 'status' => 'failed'], 404);
        }

        $diningTable->update($request->only('floor', 'size', 'num', 'status'));
        return response()->json(['message' => "The dinig tables has been updated successfully", 'status' => 'success'], 200);
    }

    public function deleteDiningTable($id)
    {
        $diningTable = DiningTable::find($id);
        if (!$diningTable) {
            return response()->json(['message' => 'Dining table not found', 'status' => 'failed'], 404);
        }

        $diningTable->delete();
        return response()->json(['message' => 'Dining table deleted successfully', 'status' => 'success'], 200);
    }

    //filter dining table
    public function filterDiningTable(Request $request)
    {
        $query = DiningTable::query();
        $filters = $request->only(['num', 'size', 'floor', 'status']);
        
        $statusMapping = [
            'inactive' => 0,
            'active' => 1
        ];
        
        foreach ($filters as $key => $value) {
            if (!is_null($value)) {
                if ($key == 'status') {
                    $mappedValue = $statusMapping[$value] ?? null;
                    if ($mappedValue !== null) {
                        $query->where($key, $mappedValue);
                    }
                } else {
                    $query->where($key, $value);
                }
            }
        }
        
        $dataDiningTables = $query->get(['id','num', 'size', 'floor', 'status']);
        
        if ($dataDiningTables->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'No dining tables found with the given filters'
            ], 404);
        }
        
        $dataDiningTablesWithUrls = $dataDiningTables->map(function ($diningTable) {
            $diningTable->qr_code_link = 'http://localhost:3000/customer/menu?' . http_build_query([
                'id' => $diningTable->id,
                'number' => $diningTable->num
            ]);
            return $diningTable;
        });
        
        return response()->json([
            'status' => 'success',
            'data' => $dataDiningTablesWithUrls,
        ], 200);
    }
    
    
}
