<!-- Texto Field -->
<div class="form-group col-sm-12 col-lg-12">
    {!! Form::label('texto', 'Texto:') !!}
    {!! Form::textarea('texto', null, ['class' => 'form-control']) !!}
</div>

<!-- Idautor Field -->
<div class="form-group col-sm-6">
    {!! Form::label('idautor', 'Idautor:') !!}
    {!! Form::number('idautor', null, ['class' => 'form-control']) !!}
</div>

<!-- Pagina Field -->
<div class="form-group col-sm-6">
    {!! Form::label('pagina', 'Pagina:') !!}
    {!! Form::number('pagina', null, ['class' => 'form-control']) !!}
</div>

<!-- Submit Field -->
<div class="form-group col-sm-12">
    {!! Form::submit('Save', ['class' => 'btn btn-primary']) !!}
    <a href="{!! route('textos.index') !!}" class="btn btn-default">Cancel</a>
</div>
