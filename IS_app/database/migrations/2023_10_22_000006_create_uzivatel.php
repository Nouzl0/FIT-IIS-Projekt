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
        Schema::create('uzivatel', function (Blueprint $table) {
            $table->id('id_uzivatel');
            $table->string('meno_uzivatela', 45)->nullable();
            $table->string('priezvisko_uzivatela', 45)->nullable();
            $table->string('email_uzivatela', 45)->nullable();
            $table->string('heslo_uzivatela')->nullable();
            $table->string('rola_uzivatela', 45)->nullable();
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
        Schema::dropIfExists('uzivatel');
    }
};
