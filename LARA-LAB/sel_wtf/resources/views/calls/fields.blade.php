<!-- User Id Field -->


    {!! Form::hidden('user_id', Auth::user()->id) !!}

    <div class="form-group col-sm-12">
    {!! Form::label('type', 'Type:') !!}
    <select name="type" class="form-control">
     @if(!isset($call))
        <option value="" disabled selected>Selecione uma das opções</option>
        <option value="0">option 0</option>
        <option value="1">option 1</option>
        <option value="2">option 2</option>
        <option value="3">option 3</option>
    @endif

    @if(isset($call))
        <option value="0" @if($call->type == '0') selected @endif >option 0</option>
        <option value="1" @if($call->type == '1') selected @endif >option 1</option>
        <option value="2" @if($call->type == '2') selected @endif>option 2</option>
        <option value="3" @if($call->type == '3') selected @endif>option 3</option>
    @endif
    </select>
</div>
<!-- Client Name Field -->
<div class="form-group col-sm-12">
    {!! Form::label('client_name', 'Client Name:') !!}
    {!! Form::text('client_name', null, ['class' => 'form-control']) !!}
</div>


<!-- Description Field -->
<div class="form-group col-sm-12 col-lg-12">
    {!! Form::label('description', 'Description:') !!}
    {!! Form::textarea('description', null, ['class' => 'form-control']) !!}
</div>

<!-- Submit Field -->
<div class="form-group col-sm-12">
    {!! Form::submit('Save', ['class' => 'btn btn-primary']) !!}
    <a href="{!! route('calls.index') !!}" class="btn btn-default">Cancel</a>
</div>

