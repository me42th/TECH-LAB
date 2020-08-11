<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ControladorCliente extends Controller
{
    private $clientes = [
        ['id' => 1,'dados' => [ 'nome' => 'Fulano' ] ],
        ['id' => 2,'dados' => [ 'nome' => 'Beltrano' ] ],
        ['id' => 3,'dados' => [ 'nome' => 'Cicrano' ] ]
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
        if(false){
            echo "<ol>";
            foreach($this->clientes as $cliente)
            {
                echo "<li> {$cliente['dados']['nome']}</li>";
            }
            echo "</ol>";
        }
        $clientes = session('clientes');

        //return view('clientes.index',['clientes' => $this->clientes]);
        return view('clientes.index',compact(['clientes']));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('clientes.create');
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
        $cliente = ['id' => count($clientes)+1,'dados' => [ 'nome' => $request->nome ] ];
        $clientes[count($clientes)] = $cliente;
        session(['clientes' => $clientes]);
        return redirect()->route('cliente.index');
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
        $cliente = $clientes[$id-1];
        return view('clientes.info',compact('cliente'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        return ':)';
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
        return ':)';
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        return ':)';
    }
}
