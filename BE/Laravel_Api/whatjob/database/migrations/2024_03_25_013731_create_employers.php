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
        if(Schema::hasTable('employers')) return;
        Schema::create('employers', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('companyName')->unique();
            $table->string('logo');
            $table->string('description');
            $table->string('hotline');
            $table->string('address');
            $table->timestamps();
            $table->foreign('id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employers');
    }
};
