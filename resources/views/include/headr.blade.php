<nav class="navbar navbar-expand-lg bg-light">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">{{config('app.name')}}</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarText">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#">Home</a>
          </li>
          @auth
          <li class="nav-item">
            <a class="nav-link" href="{{route('logout')}}">LOGOUT</a>
          </li>
          <li class="nav-item">
            <li class="nav-item">
                <a class="nav-link" href="{{ route('product.edit', auth()->user()->id) }}">Edit Profile</a>
            </li>
          @else
          <li class="nav-item">
            <a class="nav-link" href="{{route('login')}}">LOGIN</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="{{route('register')}}">REGISTERTION</a>
          </li>

       >
          </li>
@endauth
        </ul>
        <span class="navbar-text">
            @auth
            {{auth()->user()->firstname}}
            @endauth
        </span>
      </div>
    </div>
  </nav>
