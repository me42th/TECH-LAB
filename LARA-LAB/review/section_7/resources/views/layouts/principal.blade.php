<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="{{asset('css/principal.css')}}">
    <title>@yield('titulo')</title>

</head>
<body>
    <div class="row">
        <div class="col1">
            <div class="menu">
                <ul>
                    <li><a class="{{request()->routeIs('vogais')?'active':''}}" href="{{route('vogais')}}">Vogais</a></li>
                    <li><a class="{{request()->routeIs('sete.*')?'active':''}}" href="{{route('sete.index')}}">Letras</a></li>
                    <li><a class="{{request()->routeIs('numbers')?'active':''}}" href="{{route('numbers')}}">Numeros</a></li>
                </ul>
            </div>
        </div>
        <div class="col2">
            @yield('conteudo')
        </div>
    </div>
</body>
</html>
