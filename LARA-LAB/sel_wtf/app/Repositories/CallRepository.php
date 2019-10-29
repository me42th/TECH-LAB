<?php

namespace App\Repositories;

use App\Models\Call;
use App\Repositories\BaseRepository;

/**
 * Class CallRepository
 * @package App\Repositories
 * @version October 29, 2019, 2:56 pm UTC
*/

class CallRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        'user_id',
        'client_name',
        'type',
        'description'
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
        return Call::class;
    }
}
