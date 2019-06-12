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
        @hasSection ('my_section')
            @yield("my_section")
        @endif
        </div>
    </body>


</html>
