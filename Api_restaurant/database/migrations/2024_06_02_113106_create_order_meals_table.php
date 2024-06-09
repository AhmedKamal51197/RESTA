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
        Schema::create('order_meals', function (Blueprint $table) {
            // $table->unsignedBigInteger('order_id');
            // $table->unsignedBigInteger('meal_id');
            $table->foreignId('order_id')->constrained('orders')->onDelete('cascade')->onUpdate('cascade');
           
            // $table->foreign('order_id')
            // ->references('id')
            // ->on('orders')
            // ->onDelete('cascade')
            // ->onUpdate('cascade');
            $table->foreignId('meal_id')->constrained('meals')->onDelete('cascade')->onUpdate('cascade');

            // $table->foreign('meal_id')
            // ->references('id')
            // ->on('meals')
            // ->onDelete('cascade')
            // ->onUpdate('cascade');
            $table->primary(['meal_id', 'order_id']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_meals');
    }
};
