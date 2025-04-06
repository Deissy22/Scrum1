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
        Schema::create('usuarios', function (Blueprint $table) {
            $table->increments('cod_usr');
            $table->string('nombre', 50);
            $table->integer('documento')->unique();
            $table->string('correo', 50)->unique();
            $table->string('contraseña', 50);
            $table->enum('rol',['A','T','V','C']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('usuarios');
    }
};
