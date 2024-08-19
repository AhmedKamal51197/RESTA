<?php

use Illuminate\Support\Facades\Route;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

//New to check if the application key is being read correctly
Route::get('/check-key', function() {
    return response()->json(['app_key' => config('app.key')]);
});

// routes/web.php or routes/api.php

// Route::get('/storage/{filename}', function ($filename) {
//     $path = storage_path('../storage/app/public/' . $filename);

//     if (!File::exists($path)) {
//         abort(404);
//     }

//     $file = File::get($path);
//     $type = File::mimeType($path);

//     $response = Response::make($file, 200);
//     $response->header("Content-Type", $type);

//     return $response;
// })->name('storage');


