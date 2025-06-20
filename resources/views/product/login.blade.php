@extends('product.layout')
@section('title','login')
@section('content')
<div class="container">

    <div class="mt-5">
        @if ($errors->any())
        @foreach ($errors->all() as $error)
        <div class="alert alert-danger" role="alert">
           {{$error}}
          </div>

        @endforeach

        @endif


        @if (session()->has('error') )
        <div class="alert alert-danger" role="alert">
            {{session('error')}}
           </div>
           @endif


           @if (session()->has('success') )
        <div class="alert alert-success" role="alert">
            {{session('success')}}
           </div>
           @endif


        </div>


    <form action={{route('login.post')}} method="post" style="width: 500 px">
        @csrf
        <div class="mb-3">
            <label  class="form-label">Email address</label>
            <input type="email" class="form-control" name="email">
          </div>
        <div class="mb-3">
          <label  class="form-label">Password</label>
          <input type="password" class="form-control" name="password">
        </div>
        <button type="submit" class="btn btn-primary">LOGIN</button>
      </form>
</div>
@endsection
