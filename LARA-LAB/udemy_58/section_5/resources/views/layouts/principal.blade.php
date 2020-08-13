<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <style>
        .row {
            display: flex;
        }

        .col1 {
            flex: 30%;
            padding: 10px;
        }

        .col2 {
            flex: 70%;
            padding: 10px;
        }

        .menu ul
        {
            margin: 0px;
            padding: 0px;
            list-style-type: none;
        }

        .menu li
        {
            list-style: none;
        }

        .menu a
        {
            display: block;
            width: 200px;
            height: 20px;
            color: black;
            background-color: #FFFFFF;
            text-decoration: none;
            text-align: center;
            margin: 5px;
            font-size: 18px;
        }

        .menu a:hover
        {
            background-color: #b9bcd0;
            color: #0000ff;
            font-weight: bold;
        }

        .menu .active
        {
            background-color: #c0d4f3;
        }

    </style>
</head>
<body>
    @yield('conteudo')
</body>
</html>
