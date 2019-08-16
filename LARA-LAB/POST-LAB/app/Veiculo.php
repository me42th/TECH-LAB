<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Veiculo extends Model
{
 protected $table = "public.bas_veiculo";
 /**
 * The attributes that are mass assignable.
 *
 * @var array
 */
 protected $fillable = [
 'id_bas_empresa','id','codigo' ,'placa' ,'capacidade' ,'descricao' ,'ano' ,'modelo' ,'conservacao' ,'chassi' ,'prefixo' ,'id_bas_veiculo_tipo' ,'revisao_preventiva' ,'pneu_estado' ,'sit_atual_funcionamento' ,'insp_ccv' ,'hor_km' ,'local' ,'licenciamento' ,'tag_smec' ,'marca' ,'tipo' ,'cor' ,'motor' ,'renavam' ,'combustivel' ,'empresa' ,'tacografo' ,'tipo_propriedade' ,'observacao' ,'quantidade_em_pe' ,'quantidade_sentado'];
}
/*

