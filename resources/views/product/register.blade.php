@extends('product.layout')
@section('title','Register')
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

    <form action={{route('register.post')}} method="post" width="500px">
        @csrf
        <div class="mb-3">
          <label class="form-label">First name</label>
          <input type="text" class="form-control" name="firstname">
        </div>
        <div class="mb-3">
            <label  class="form-label">Last name</label>
            <input type="text" class="form-control" name="lastname" >

          </div>
          <div class="mb-3">
            <label  class="form-label">address</label>
            <input type="text" class="form-control" name="address" >

          </div>


          <div class="mb-3">
            <label  class="form-label">phone number</label>
            <input type="text" class="form-control" name="phone_number" >

          </div>


        <div class="mb-3">
            <label  class="form-label">Email address</label>
            <input type="email" class="form-control" name="email">
          </div>
        <div class="mb-3">
          <label  class="form-label">Password</label>
          <input type="password" class="form-control" name="password">
        </div>
        <button type="submit" class="btn btn-primary">CREATE ACCOUNT</button>
        <div></div>
      </form>
</div>
@endsection
