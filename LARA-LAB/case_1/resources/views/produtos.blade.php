<html>
    <head>
        <!--<link href="{{asset('css/app.css')}}" rel="stylesheet">-->
        <link href="{{URL::to('css/app.css')}}" rel="stylesheet">
    </head>
    <body>

        @if(isset($produtos))
            @if(count($produtos) > 1)
                @alert(['type' => 'primary', 'titulo' => 'Temos '.count($produtos).' produtos'])@endalert
            @elseif(count($produtos) == 1)
                @alert(['type' => 'primary', 'titulo' => 'Temos '.count($produtos).' produto'])@endalert
            @else
                @alert(['type' => 'danger', 'titulo' => 'Nenhum produto'])@endalert
            @endif
        @endif

        <!--<script href="{{asset('js/app.js')}}" type="text/javascript"></script>-->
        <script href="{{URL::to('js/app.js')}}" type="text/javascript"></script>
    </body>

</html>
