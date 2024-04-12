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
        if(Schema::hasTable('employees')) return;
        Schema::create('employees', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('fullname');
            $table->string('avatar');
            $table->string('phoneNumber')->unique();
            $table->string('introduction');
            $table->string('certification');
            $table->string('cv');
            $table->string('gender');
            $table->string('address');
            $table->string('born');
            $table->timestamps();
            $table->uuid('field_id')->nullable();
            $table->foreign('field_id')->references('id')->on('fields')->onDelete('cascade');
            $table->foreign('id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employees');
    }
};
