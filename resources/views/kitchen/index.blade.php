@extends('product.layout')
@section('title', 'kitchen')
@section('content')
<div class="container">


    @foreach ($categories as $category)


    <div class="card" style="width: 18rem;">
      <img src="https://www.le-studio3d.com/wp-content/uploads/2022/05/3D-photo-kitchen-furniture3.jpg" class="card-img-top" alt="..."> <div class="card-body">
        <h5 class="card-title"> {{$category->name}}</h5>
        <p class="card-text">Some 1  quick example text to build on the card title and make up the bulk of the card's content.</p>
        <form action= "{{route('kitchen.order')}}" method="get" style="display: inline-block;">

          <button type="submit">عرض</button>

          <li class="list-group-item"></li>
        </div>
      </div>
    </form>
@endforeach
</div>

@endsection
