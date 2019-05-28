<html>
    <head>
        <!--<link href="{{asset('css/app.css')}}" rel="stylesheet">-->
        <link href="{{URL::to('css/app.css')}}" rel="stylesheet">
    </head>
    <body>

        @alert(['type' => 'danger','titulo' => 'Erro Fatal'])
            <strong> ERROR </strong>
            <!--@ slot('titulo')
                Erro Fatal
            @ endslot
            @ slot('type','danger')-->
        @endalert


        <!--<script href="{{asset('js/app.js')}}" type="text/javascript"></script>-->
        <script href="{{URL::to('js/app.js')}}" type="text/javascript"></script>
    </body>

</html>
