<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\RealState;
use App\Http\Resources\RealStateCollection;
use App\Http\Resources\RealStateResource;
use App\Http\Requests\RealStateStoreRequest;

class RealStateController extends Controller
{
    private $realState;
    public function __construct(RealState $realState){
        $this->realState = $realState;
    }

    public function index(){
        return new RealStateCollection($this->realState->paginate(10),'ok');
    }

    public function show($id){
        return response()->json(['location' => __METHOD__]);
    }

    public function store(RealStateStoreRequest $request){
        try{
            $realState = RealState::create($request->all());
        } catch(\Exception $ex){
            return response()->json(['msg' => $ex->getMessage()],500);
        }
        return new RealStateResource($realState,201,'Created');
    }

    public function update(Request $request){
        return response()->json(['location' => __METHOD__]);
    }

    public function destroy($id){
        return response()->json(['location' => __METHOD__]);
    }


}
