<?php

namespace App\Repositories;

use App\Models\Texto;
use App\Repositories\BaseRepository;

/**
 * Class TextoRepository
 * @package App\Repositories
 * @version August 16, 2019, 12:41 pm UTC
*/

class TextoRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        'texto',
        'idautor',
        'pagina'
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
        return Texto::class;
    }
}
