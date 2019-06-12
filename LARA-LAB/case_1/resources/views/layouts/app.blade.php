<html>
    <head>
        <title> @yield("title") </title>
    </head>
    <body>
        @section("family-content")
        <h1>PAI</h1>
        @show
        <div>
            @yield("content")
        </div>
        <div>
            @yield("my_section")
        </div>
    </body>


</html>
