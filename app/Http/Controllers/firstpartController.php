<?php

namespace App\Http\Controllers;
use App\Models\Category;
use App\Models\Item;
use App\Models\Order;
use JWT;
use Illuminate\Http\Request;

class firstpartController extends Controller
{
    public function index()
    {
        $categories = Category::all();
        return view('kitchen.index', compact('categories'));
    }

    public function addOrder(Request $request)
    {
        $request->validate([
            'item_name' => 'required|string|exists:items,name',
            'details' => 'required',
        ]);
        $userId = JWTAuth::user()->id;

        $item = Item::where('name', $request->item_name)->first();

    if (!$item) {
        return response()->json(['message' => 'Item not found'], 404);
    }

        $data = [
            'item_name' => $request->item_name,
            'user_id' => $userId,
            'details' => $request->details,
            'item_id' => $item->id,
        ];

        $order = Order::create($data);

        if (!$order) {
            return response()->json(['message' => 'Failed to create order'], 500);
        }

        return response()->json([
            'message' => 'Order created successfully',
            'order' => $order
        ], 201);
    }

    public function order()
    {
        $categories = Category::all();
        $orders = Order::where('user_id', auth()->id())->get();
        return view('kitchen.order', compact('categories', 'orders'));
    }

    public function editOrder($id)
{
    $order = Order::findOrFail($id);
    $orders = Order::where('user_id', auth()->id())->get();
    return view('kitchen.edit', compact('orders', 'order'));
}
public function orderview(){
    $categories = Category::all();
    $orders = Order::where('user_id', auth()->id())->get();
    return view('kitchen.vieworder', compact('categories', 'orders'));



}
    public function updateOrder(Request $request, $orderId)
    {
            $request->validate([
                'quantity' => 'required',
            ]);
            $order = Order::findOrFail($orderId);
            $order->quantity = $request->quantity;
                $order->save();

            return redirect(route('kitchen.order'))->with('success', 'Order update successfully');

    }

    public function deleteOrder($orderId)
    {
        $order = Order::where('id', $orderId)->delete();

        return redirect(route('kitchen.order'))->with('success', 'Order deleted successfully');
    }
}
