@extends('product.layout')
@section('title', 'Edit Order')
@section('content')
<div class="container">
    <h3>Edit Order: {{ $order->item->name }}</h3>

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

    <form action="{{ route('kitchen.order.update', $order->id) }}" method="POST">
        @csrf
        <div class="mb-3">
            <label for="quantity" class="form-label">Quantity</label>
            <input type="text" name="quantity" id="quantity" class="form-control" value="{{ old('quantity', $order->quantity) }}">
        </div>
        <button type="submit" class="btn btn-success">Update Order</button>
    </form>


    <form action="{{ route('kitchen.order.delete', $order->id) }}" method="POST" onsubmit="return confirm('Are you sure you want to delete this order?');" class="mt-3">
        @csrf
        @method('DELETE')
        <button type="submit" class="btn btn-danger">Delete Order</button>
    </form>
    @endforeach
</div>
@endsection
