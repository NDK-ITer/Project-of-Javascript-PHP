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
        if(Schema::hasTable('recruitment_articles')) return;
        Schema::create('recruitment_articles', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name');
            $table->string('requirement');
            $table->string('description');
            $table->string('image');
            $table->string('salary');
            $table->string('addressWork');
            $table->string('isApproved');
            $table->string('endSubmission');
            $table->string('ageEmployee');
            $table->string('countEmployee');
            $table->string('formOfWork');
            $table->string('yearsOfExperience');
            $table->string('degree');
            $table->uuid('employer_id')->nullable();
            $table->foreign('employer_id')->references('id')->on('employers')->onDelete('cascade');
            $table->uuid('field_id')->nullable();
            $table->foreign('field_id')->references('id')->on('fields')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('recruitment_aricles');
    }
};
