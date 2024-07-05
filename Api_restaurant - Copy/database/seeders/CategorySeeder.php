<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon; // Add this import to use Carbon for date and time handling

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
    */
    public function run()
    {
        $now = Carbon::now(); // Get the current date and time

        DB::table('categories')->insert([
            ['name' => 'Beverages', 'description' => 'Drinks and refreshments', 'created_at' => $now, 'updated_at' => $now],
            ['name' => 'Food', 'description' => 'Meals and snacks', 'created_at' => $now, 'updated_at' => $now],
            ['name' => 'Desserts', 'description' => 'Sweet treats', 'created_at' => $now, 'updated_at' => $now],
        ]);
    }
}
