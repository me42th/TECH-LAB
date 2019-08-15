@extends('layouts.app')

@section('content')
    <section class="content-header">
        <h1>
            Autor
        </h1>
   </section>
   <div class="content">
       @include('adminlte-templates::common.errors')
       <div class="box box-primary">
           <div class="box-body">
               <div class="row">
                   {!! Form::model($autor, ['route' => ['autors.update', $autor->id], 'method' => 'patch']) !!}

                        @include('autors.fields')

                   {!! Form::close() !!}
               </div>
           </div>
       </div>
   </div>
@endsection