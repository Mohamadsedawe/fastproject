@extends('product.layout')
@section('title', 'Order')
@section('content')
<div class="container">
    <div class="mt-5">
        @if ($errors->any())
            @foreach ($errors->all() as $error)
                <div class="alert alert-danger" role="alert">{{ $error }}</div>
            @endforeach
        @endif

        @if (session()->has('error'))
            <div class="alert alert-danger" role="alert">{{ session('error') }}</div>
        @endif

        @if (session()->has('success'))
            <div class="alert alert-success" role="alert">{{ session('success') }}</div>
        @endif
    </div>

    @foreach ($categories as $category)
        @foreach ($category->items as $item)
            <div class="card" style="width: 18rem; margin-bottom: 20px;">
                <img src="https://img.freepik.com/free-vector/red-black-open-refrigerator-with-products_1284-23311.jpg?semt=ais_hybrid" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">{{ $item->name }}</h5>
                    <p class="card-text">Select quantity to add to your order.</p>
                </div>
                <ul class="list-group list-group-flush">

                    <form action="{{ route('kitchen.orderpost') }}" method="POST" style="display: inline-block; margin-bottom: 10px;">
                        @csrf
                        <input type="hidden" name="item_id" value="{{ $item->id }}">
                        <input type="text" name="quantity" placeholder="Quantity"  style="display: inline-block; margin-bottom: 30px;" >
                        <button type="submit" class="btn btn-success w-100">Add Order</button>
                    </form>

                    <form action="{{ route('kitchen.orderview') }}" method="GET" style="display: inline-block; margin-bottom: 10px;">
                        <button type="submit" class="btn btn-success w-100">عرض الطلبات</button>
                    </form>
                    <button type="submit" class="btn btn-danger ">طوارى</button>
                </ul>
            </div>
        @endforeach
    @endforeach
</div>
@endsection
