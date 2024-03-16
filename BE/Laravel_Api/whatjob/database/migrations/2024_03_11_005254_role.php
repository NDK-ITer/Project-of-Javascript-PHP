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
        if(Schema::hasTable('roles')) return;
        Schema::create('roles', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->String('Name')-> nullable();
            $table->String('NormalizeName')-> nullable();
            $table->timestamps();
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
