<?php
namespace App\Http\Resources;

class ApiError {
    private $message = [],$code;
    public function __construct(string $title,int $code = 500,array $data = []){
        $this->message['status'] = $title;
        $this->code = $code;
        $this->message['errors'] = $data;
    }

    public static function make(string $title,int $code = 500,array $data = []){
        return (new ApiError($title,$code,$data))->response();
    }

    public function __toString(){
        return json_encode($this->message);
    }

    public function response(){
        return response()->json($this->message,$this->code);
    }

    public function push($error){
        array_push($this->message['errors'],$error);
    }
}
