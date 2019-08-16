<div class="table-responsive">
    <table class="table" id="veiculos-table">
        <thead>
            <tr>
                <th>Id</th>
        <th>Codigo</th>
        <th>Placa</th>
        <th>Capacidade</th>
        <th>Descricao</th>
        <th>Ano</th>
        <th>Modelo</th>
        <th>Conservacao</th>
        <th>Chassi</th>
        <th>Prefixo</th>
        <th>Id Bas Veiculo Tipo</th>
        <th>Revisao Preventiva</th>
        <th>Pneu Estado</th>
        <th>Sit Atual Funcionamento</th>
        <th>Insp Ccv</th>
        <th>Hor Km</th>
        <th>Local</th>
        <th>Licenciamento</th>
        <th>Tag Smec</th>
        <th>Marca</th>
        <th>Tipo</th>
        <th>Cor</th>
        <th>Motor</th>
        <th>Renavam</th>
        <th>Combustivel</th>
        <th>Empresa</th>
        <th>Tacografo</th>
        <th>Tipo Propriedade</th>
        <th>Observacao</th>
        <th>Quantidade Em Pe</th>
        <th>Quantidade Sentado</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($veiculos as $veiculo)
            <tr>
                <td>{!! $veiculo->id !!}</td>
            <td>{!! $veiculo->codigo !!}</td>
            <td>{!! $veiculo->placa !!}</td>
            <td>{!! $veiculo->capacidade !!}</td>
            <td>{!! $veiculo->descricao !!}</td>
            <td>{!! $veiculo->ano !!}</td>
            <td>{!! $veiculo->modelo !!}</td>
            <td>{!! $veiculo->conservacao !!}</td>
            <td>{!! $veiculo->chassi !!}</td>
            <td>{!! $veiculo->prefixo !!}</td>
            <td>{!! $veiculo->id_bas_veiculo_tipo !!}</td>
            <td>{!! $veiculo->revisao_preventiva !!}</td>
            <td>{!! $veiculo->pneu_estado !!}</td>
            <td>{!! $veiculo->sit_atual_funcionamento !!}</td>
            <td>{!! $veiculo->insp_ccv !!}</td>
            <td>{!! $veiculo->hor_km !!}</td>
            <td>{!! $veiculo->local !!}</td>
            <td>{!! $veiculo->licenciamento !!}</td>
            <td>{!! $veiculo->tag_smec !!}</td>
            <td>{!! $veiculo->marca !!}</td>
            <td>{!! $veiculo->tipo !!}</td>
            <td>{!! $veiculo->cor !!}</td>
            <td>{!! $veiculo->motor !!}</td>
            <td>{!! $veiculo->renavam !!}</td>
            <td>{!! $veiculo->combustivel !!}</td>
            <td>{!! $veiculo->empresa !!}</td>
            <td>{!! $veiculo->tacografo !!}</td>
            <td>{!! $veiculo->tipo_propriedade !!}</td>
            <td>{!! $veiculo->observacao !!}</td>
            <td>{!! $veiculo->quantidade_em_pe !!}</td>
            <td>{!! $veiculo->quantidade_sentado !!}</td>
                <td>
                    {!! Form::open(['route' => ['veiculos.destroy', $veiculo->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{!! route('veiculos.show', [$veiculo->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-eye-open"></i></a>
                        <a href="{!! route('veiculos.edit', [$veiculo->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-edit"></i></a>
                        {!! Form::button('<i class="glyphicon glyphicon-trash"></i>', ['type' => 'submit', 'class' => 'btn btn-danger btn-xs', 'onclick' => "return confirm('Are you sure?')"]) !!}
                    </div>
                    {!! Form::close() !!}
                </td>
            </tr>
        @endforeach
        </tbody>
    </table>
</div>
