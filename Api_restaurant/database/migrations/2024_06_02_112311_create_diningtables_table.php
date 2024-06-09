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
        Schema::create('diningtables', function (Blueprint $table) {
            $table->id();
            $table->integer('floor');
            $table->integer('size');
            $table->integer('num');
            $table->string('status');
            $table->unique(['floor','num']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('diningtables');
    }
};
