<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('employees', function (Blueprint $table) {
            $table->uuid('field_id')->nullable();
            $table->foreign('field_id')->references('id')->on('fields')->onDelete('cascade');
        });
    }

    public function down()
    {
    }
};
