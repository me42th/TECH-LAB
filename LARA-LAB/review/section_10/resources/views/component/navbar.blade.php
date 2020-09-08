<nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbar">
      <ul class="navbar-nav mr-auto">
      <li class="nav-item @if($current == 'home') active @endif">
            <a class="nav-link" href="{{route('index')}}">Home</a>
        </li>
        <li class="nav-item ">
            <a class="nav-link @if($current == 'product') active @endif" href="{{route('product.index')}}">Produtos</a>
        </li>
        <li class="nav-item ">
            <a class="nav-link @if($current == 'category') active @endif" href="{{route('category.index')}}">Categorias</a>
        </li>
      </ul>

    </div>
  </nav>
