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
        if(Schema::hasTable('enjoys')) return;
        Schema::create('enjoys', function (Blueprint $table) {
            $table->uuid('employee_id');
            $table->uuid('recruitment_article_id');
            $table->primary(['employee_id', 'recruitment_article_id']);
            $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');
            $table->foreign('recruitment_article_id')->references('id')->on('recruitment_articles')->onDelete('cascade');
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('enjoys');
    }
};
