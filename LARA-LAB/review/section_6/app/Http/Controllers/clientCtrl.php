<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class clientCtrl extends Controller
{

    private $clientes = [
        [
            'id' => '1',
            'nome' => 'David'
        ],
        [
            'id' => '2',
            'nome' => 'Felipe'
        ],
        [
            'id' => '3',
            'nome' => 'Chiclete'
        ],
        [
            'id' => '4',
            'nome' => 'Pé de Pranta'
        ]
    ];
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $clients = $this->clientes;
        return view('client.index',compact(['clients']));
    }

    public function index_a(){
        $lista = '';
        foreach($this->clientes as $cliente){
            $lista .= "<li>{$cliente['nome']}</li>";
        }
        echo "<ol>$lista</ol>";
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('client.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $id = count($this->clientes);
        $nome = $request->nome;
        $dados = ['id' => $id,'nome' => $nome];
        $this->clientes[]  = $dados;
        dd($this->clientes);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
