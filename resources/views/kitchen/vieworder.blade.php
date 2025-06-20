@extends('product.layout')
@section('title', 'Your Orders')
@section('content')
<div class="container">
    <h3>Your Orders</h3>

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


    @foreach ($orders as $order)
        <div class="card mb-3">
            <div class="card-body">
                <h5 class="card-title">{{ $order->item->name }} - Quantity: {{ $order->quantity }}</h5>


                <form action="{{ route('kitchen.order.edit', $order->id) }}" method="GET" style="display: inline-block; margin-bottom: 10px;">
                    <button type="submit" class="btn btn-warning">Edit Order</button>
                </form>


                <form action="{{ route('kitchen.order.delete', $order->id) }}" method="POST" style="display: inline-block; margin-bottom: 10px;"  onsubmit="return confirm('Are you sure you want to delete this order?');" class="mt-3">
                    @csrf
                    @method('DELETE')
                    <button type="submit" class="btn btn-danger">Delete Order</button>
                </form>
            </div>
        </div>
    @endforeach


    @if ($orders->isEmpty())
        <div class="alert alert-info" role="alert">
            You have no orders yet.
        </div>
    @endif
</div>


@endsection
