<?php

namespace App\Models;

use Eloquent as Model;

/**
 * @SWG\Definition(
 *      definition="Veiculo",
 *      required={""},
 *      @SWG\Property(
 *          property="id",
 *          description="Identificador sequencial da tabela, chave primaria composta com o campo id_bas_empresa",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="id_bas_empresa",
 *          description="Identificador da tabela bas_empresa,  chave primaria composta com o campo id",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="codigo",
 *          description="Código do veículo fornecido pelo usuário",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="placa",
 *          description="Placa do carro",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="capacidade",
 *          description="Capacidade do veículo",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="descricao",
 *          description="Descrição do veículo",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="ano",
 *          description="ano",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="modelo",
 *          description="modelo",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="conservacao",
 *          description="conservacao",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="chassi",
 *          description="chassi",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="prefixo",
 *          description="prefixo",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="id_bas_veiculo_tipo",
 *          description="id_bas_veiculo_tipo",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="revisao_preventiva",
 *          description="revisao_preventiva",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="pneu_estado",
 *          description="pneu_estado",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="sit_atual_funcionamento",
 *          description="sit_atual_funcionamento",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="insp_ccv",
 *          description="insp_ccv",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="hor_km",
 *          description="hor_km",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="local",
 *          description="local",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="licenciamento",
 *          description="licenciamento",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="tag_smec",
 *          description="tag_smec",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="marca",
 *          description="marca",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="tipo",
 *          description="tipo",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="cor",
 *          description="cor",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="motor",
 *          description="motor",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="renavam",
 *          description="renavam",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="combustivel",
 *          description="combustivel",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="empresa",
 *          description="empresa",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="tacografo",
 *          description="tacografo",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="tipo_propriedade",
 *          description="tipo_propriedade",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="observacao",
 *          description="observacao",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="quantidade_em_pe",
 *          description="quantidade_em_pe",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="quantidade_sentado",
 *          description="quantidade_sentado",
 *          type="integer",
 *          format="int32"
 *      )
 * )
 */
class Veiculo extends Model
{

    public $table = 'bas_veiculo';
    
    public $timestamps = false;



    public $fillable = [
        'id',
        'codigo',
        'placa',
        'capacidade',
        'descricao',
        'ano',
        'modelo',
        'conservacao',
        'chassi',
        'prefixo',
        'id_bas_veiculo_tipo',
        'revisao_preventiva',
        'pneu_estado',
        'sit_atual_funcionamento',
        'insp_ccv',
        'hor_km',
        'local',
        'licenciamento',
        'tag_smec',
        'marca',
        'tipo',
        'cor',
        'motor',
        'renavam',
        'combustivel',
        'empresa',
        'tacografo',
        'tipo_propriedade',
        'observacao',
        'quantidade_em_pe',
        'quantidade_sentado'
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
    protected $casts = [
        'id' => 'integer',
        'id_bas_empresa' => 'integer',
        'codigo' => 'string',
        'placa' => 'string',
        'capacidade' => 'integer',
        'descricao' => 'string',
        'ano' => 'integer',
        'modelo' => 'string',
        'conservacao' => 'string',
        'chassi' => 'string',
        'prefixo' => 'string',
        'id_bas_veiculo_tipo' => 'integer',
        'revisao_preventiva' => 'string',
        'pneu_estado' => 'string',
        'sit_atual_funcionamento' => 'string',
        'insp_ccv' => 'string',
        'hor_km' => 'string',
        'local' => 'string',
        'licenciamento' => 'string',
        'tag_smec' => 'string',
        'marca' => 'string',
        'tipo' => 'string',
        'cor' => 'string',
        'motor' => 'string',
        'renavam' => 'string',
        'combustivel' => 'string',
        'empresa' => 'string',
        'tacografo' => 'string',
        'tipo_propriedade' => 'string',
        'observacao' => 'string',
        'quantidade_em_pe' => 'integer',
        'quantidade_sentado' => 'integer'
    ];

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        'id_bas_empresa' => 'required',
        'codigo' => 'required',
        'placa' => 'required'
    ];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     **/
    public function idBasEmpresa()
    {
        return $this->belongsTo(\App\Models\BasEmpresa::class, 'id_bas_empresa');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     **/
    public function idBasVeiculoTipo()
    {
        return $this->belongsTo(\App\Models\BasVeiculoTipo::class, 'id_bas_veiculo_tipo');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     **/
    public function sgeTransporteRoteiro()
    {
        return $this->hasOne(\App\Models\SgeTransporteRoteiro::class);
    }
}
