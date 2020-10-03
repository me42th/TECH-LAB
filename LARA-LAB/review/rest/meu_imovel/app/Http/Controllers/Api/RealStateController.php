<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\RealState;
use App\Http\Resources\RealStateCollection;
use App\Http\Resources\RealStateResource;
use App\Http\Requests\RealStateStoreRequest;
use App\Http\Requests\RealStateUpdateRequest;

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
        try{
            $realState = RealState::findOrFail($id);
        }catch(\Exception $ex){
            return response()->json(['msg'=>$ex->getMessage()],422);
        }
        return new RealStateResource($realState,200,'Ok');
    }

    public function store(RealStateStoreRequest $request){
        try{
            $realState = RealState::create($request->all());
        } catch(\Exception $ex){
            return response()->json(['msg' => $ex->getMessage()],500);
        }
        return new RealStateResource($realState,201,'Created');
    }

    public function update($id,RealStateUpdateRequest $request){
        try{
            $realState = RealState::findOrFail($id);
            $realState->fill($request->all());
            $realState->save();
        } catch(\Exception $ex){
            return response()->json(['msg' => $ex->getMessage()],422);
        }
        return new RealStateResource($realState,202,'Updated');
    }

    public function destroy($id){
        try{
            $realState = RealState::findOrFail($id);
            $realState->delete();
        } catch(\Exception $ex){
            return response()->json(['msg' => $ex->getMessage()],422);
        }
        return new RealStateResource($realState,202,'Deleted');
    }


}
