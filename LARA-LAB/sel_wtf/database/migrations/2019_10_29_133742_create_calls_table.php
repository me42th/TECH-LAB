<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCallsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('calls', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('user_id')->comment('Chave extrangeira do técnico que cadastrou atendimento');
            $table->string('client_name')->comment('Cliente que foi atendido');
            $table->enum('type', ['0','1','2','3'])->default(0)->comment('[0 | Tipo 0][1 | Tipo 1][2 | Tipo 2][3 | Tipo 3]');
            $table->longText('description')->nullable()->comment('Observação do atendimento');
            $table->softDeletes();
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
        Schema::dropIfExists('calls');
    }
}
