<?php

namespace App\Http\Controllers;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Models\Category;
use App\Models\Item;
use App\Models\Order;
use JWT;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class KitchenController extends Controller
{
    public function index()
    {
        $categories = Category::all();
        return view('kitchen.index', compact('categories'));
    }

    public function addOrder(Request $request)
    {

        //dd($request->all());


         $validated = Validator::make($request->all(), [
            'item_name' => 'required|string|exists:items,name',
            'details' => 'required',
        ]);
        if ($validated->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validated->errors()
            ], 400);
        }
        $item = Item::where('name', $request->item_name)->first();

        if (!$item) {
            return response()->json(['message' => 'Item not found'], 404);
        }

        $userId = JWTAuth::user()->id;

        $data = [
            'item_name' => $request->item_name,
            'item_id' => $item->id,
            'user_id' => $userId,
            'details' => $request->details,

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
    public function getOrders()
{
    $orders = Order::where('user_id', JWTAuth::user()->id)->get();

    // إرجاع الطلبات على شكل JSON
    return response()->json([
        'message' => 'Orders fetched successfully',
        'orders' => $orders
    ], 200);
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
