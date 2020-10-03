<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\RealState;
use App\Http\Resources\RealStateCollection;

class RealStateController extends Controller
{
    private $realState;
    public function __construct(RealState $realState){
        $this->realState = $realState;
    }

    public function index(){
        return new RealStateCollection($this->realState->paginate(10),'ok');
    }
}
