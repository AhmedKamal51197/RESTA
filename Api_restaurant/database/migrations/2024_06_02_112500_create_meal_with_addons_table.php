<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('meal_with_addons', function (Blueprint $table) {
            // $table->unsignedBigInteger('meal_id');
            // $table->unsignedBigInteger('addon_id');
            $table->foreignId('meal_id')->constrained('meals')->onDelete('cascade')->onUpdate('cascade');
            // $table->foreign('meal_id')
            // ->references('id')
            // ->on('meals')
            // ->onDelete('cascade')
            // ->onUpdate('cascade');

            $table->foreignId('addon_id')->constrained('addons')->onDelete('cascade')->onUpdate('cascade');
            // $table->foreignId('addon_id')
            // ->references('id')
            // ->on('addons')
            // ->onDelete('cascade')
            // ->onUpdate('cascade');
            $table->primary(['meal_id', 'addon_id']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('meal_with_addons');
    }
};
