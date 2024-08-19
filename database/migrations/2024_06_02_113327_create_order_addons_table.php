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
        Schema::create('order_addons', function (Blueprint $table) {
            // $table->unsignedBigInteger('order_id');
            // $table->unsignedBigInteger('addon_id');
            $table->foreignId('order_id')->constrained('orders')->onDelete('cascade')->onUpdate('cascade');
            
            // $table->foreign('order_id')
            // ->references('id')
            // ->on('orders')
            // ->onDelete('cascade')
            // ->OnUpdate('cascade');
            $table->foreignId('addon_id')->constrained('addons')->onDelete('cascade')->onUpdate('cascade');

            // $table->foreign('addon_id')
            // ->references('id')
            // ->on('addons')
            // ->onDelete('cascade')
            // ->onUpdate('cascade');
            $table->primary(['order_id', 'addon_id']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_addons');
    }
};
