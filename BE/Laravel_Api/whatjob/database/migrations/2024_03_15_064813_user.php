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
        //
        if(Schema::hasTable('users')) return;
        Schema::create('users', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->String('email')-> nullable()->unique();
            $table->String('password')-> nullable();
            $table->boolean('isBlock')-> nullable();
            $table->timestamps();

            $table->uuid('role_id')->nullable();
            $table->foreign('role_id')->references('id')->on('roles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
