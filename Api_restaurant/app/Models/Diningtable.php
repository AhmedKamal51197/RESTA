<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class DiningTable extends Model
{
    use HasFactory;

    protected $fillable = [
        'floor',
        'size',
        'num',
        'status',
        'qr_code',
    ];

    protected $table = 'diningtables';

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function getCreatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }

    public function getUpdatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }

    // Generate a QR code for the dining table
    public function generateQrCode($customContent = null)
    {
        try {
            $qrCodeContent = $customContent ?? 'http://localhost:3000/customer/menu?' . $this->id;
            $qrCode = QrCode::size(400)->generate($qrCodeContent);


            $fileName = 'qrcode_' . $this->id . '_' . time() . '.png';
            $qrCodePath = 'public/qr_codes/' . $fileName;
            Storage::put($qrCodePath, $qrCode);

            $this->qr_code = $fileName;
            $this->save();

            return 'storage/qr_codes/' . $fileName;
        } catch (\Exception $e) {
            Log::error('Error generating QR code: ' . $e->getMessage());
            throw $e;
        }
    }
}
