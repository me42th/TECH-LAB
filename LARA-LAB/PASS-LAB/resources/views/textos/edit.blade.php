@extends('layouts.app')

@section('content')
    <section class="content-header">
        <h1>
            Texto
        </h1>
   </section>
   <div class="content">
       @include('adminlte-templates::common.errors')
       <div class="box box-primary">
           <div class="box-body">
               <div class="row">
                   {!! Form::model($texto, ['route' => ['textos.update', $texto->id], 'method' => 'patch']) !!}

                        @include('textos.fields')

                   {!! Form::close() !!}
               </div>
           </div>
       </div>
   </div>
@endsection