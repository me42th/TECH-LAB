<?php

namespace App\Models;

use Eloquent as Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * @SWG\Definition(
 *      definition="Autor",
 *      required={""},
 *      @SWG\Property(
 *          property="idautor",
 *          description="idautor",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="nome",
 *          description="nome",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="limite",
 *          description="limite",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="url",
 *          description="url",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="titulo",
 *          description="titulo",
 *          type="string"
 *      )
 * )
 */
class Autor extends Model
{
    use SoftDeletes;

    public $table = 'autor';

    const CREATED_AT = 'created_at';
    const UPDATED_AT = 'updated_at';

    protected $primaryKey = 'idautor';
    protected $dates = ['deleted_at'];


    public $fillable = [
        'nome',
        'limite',
        'url',
        'titulo'
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
    protected $casts = [
        'idautor' => 'integer',
        'nome' => 'string',
        'limite' => 'integer',
        'url' => 'string',
        'titulo' => 'string'
    ];

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        'idautor' => 'required'
    ];


}
