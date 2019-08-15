<?php

namespace App\Repositories;

use App\Models\Autor;
use App\Repositories\BaseRepository;

/**
 * Class AutorRepository
 * @package App\Repositories
 * @version August 15, 2019, 8:13 pm UTC
*/

class AutorRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        'nome',
        'limite',
        'url',
        'titulo'
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
        return Autor::class;
    }
}
