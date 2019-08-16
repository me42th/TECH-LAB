<?php

namespace App\Models;

use Eloquent as Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * @SWG\Definition(
 *      definition="Texto",
 *      required={""},
 *      @SWG\Property(
 *          property="idtexto",
 *          description="idtexto",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="texto",
 *          description="texto",
 *          type="string"
 *      ),
 *      @SWG\Property(
 *          property="idautor",
 *          description="idautor",
 *          type="integer",
 *          format="int32"
 *      ),
 *      @SWG\Property(
 *          property="pagina",
 *          description="pagina",
 *          type="integer",
 *          format="int32"
 *      )
 * )
 */
class Texto extends Model
{
    use SoftDeletes;

    public $table = 'texto';
    
    const CREATED_AT = 'created_at';
    const UPDATED_AT = 'updated_at';


    protected $dates = ['deleted_at'];


    public $fillable = [
        'texto',
        'idautor',
        'pagina'
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
    protected $casts = [
        'idtexto' => 'integer',
        'texto' => 'string',
        'idautor' => 'integer',
        'pagina' => 'integer'
    ];

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        'idtexto' => 'required',
        'idautor' => 'required'
    ];

    
}
