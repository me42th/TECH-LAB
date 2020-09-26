<?php

namespace App\Repository;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;


class ProductRepository{
    private $model,$request;

    public function __construct(Model $model, Request $request){
        $this->request = $request;
        $this->model = $model;
        $this->filter();
        $this->raw();
    }

    public function __get($att){
        if($att == 'products')
            return $this->model;
        throw new \Exception ("Variable $att is not public, sorry");
    }

    private function filter(){
        if($this->request->has('conditions')){
            $conditions = explode(';',$this->request->get('conditions'));
            foreach($conditions as $condition){
                $condition = explode(':',$condition);
                if(count($condition) == 2){
                    $this->model = $this->model->where($condition[0],$condition[1]);
                } else if (count($condition) == 3){
                    $this->model = $this->model->where($condition[0],$condition[1],$condition[2]);
                }
            }
        }
    }

    private function raw(){
        if($this->request->has('fields')){
            $fields = $this->request->get('fields');
            $this->model = $this->model->selectRaw($fields);
        }
    }

}
