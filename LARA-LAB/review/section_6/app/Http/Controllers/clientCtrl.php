<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class clientCtrl extends Controller
{

    private $clientes = [
        [
            'id' => '0',
            'nome' => 'David'
        ],
        [
            'id' => '1',
            'nome' => 'Felipe'
        ],
        [
            'id' => '2',
            'nome' => 'Chiclete'
        ],
        [
            'id' => '3',
            'nome' => 'Pé de Pranta'
        ]
    ];

    public function __construct(){
        $clientes = session('clientes');
        if(!isset($clientes)){
            session(['clientes' => $this->clientes]);
        }
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $clients = session('clientes');
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
        $clientes = session('clientes');
        $id = count($clientes);
        $nome = $request->nome;
        $dados = ['id' => $id,'nome' => $nome];
        $clientes[]  = $dados;
        session(['clientes' => $clientes]);
        return redirect()->route('client.index');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $clientes = session('clientes');
        $client = $clientes[$id];
        return view('client.show',compact('client'));
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
