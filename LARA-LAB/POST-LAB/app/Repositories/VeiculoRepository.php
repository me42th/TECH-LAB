<?php

namespace App\Repositories;

use App\Models\Veiculo;
use App\Repositories\BaseRepository;

/**
 * Class VeiculoRepository
 * @package App\Repositories
 * @version August 16, 2019, 6:52 pm UTC
*/

class VeiculoRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
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
     * Return searchable fields
     *
     * @return array
     */
    public function getFieldsSearchable()
    {
        return $this->fieldSearchable;
    }

    /**
     * Configure the Model
     **/
    public function model()
    {
        return Veiculo::class;
    }
}
