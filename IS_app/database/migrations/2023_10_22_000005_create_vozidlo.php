<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('vozidlo', function (Blueprint $table) {
            $table->id('id_vozidlo');
            $table->string('spz', 8)->unique()->nullable(false);
            $table->string('nazov', 45)->nullable();
            $table->string('druh_vozidla', 45)->nullable();
            $table->string('znacka_vozidla', 45)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('vozidlo');
    }
};
