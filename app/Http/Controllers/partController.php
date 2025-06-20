<?php

namespace App\Http\Controllers;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Models\Category;
use App\Models\Item;
use App\Models\User;
use App\Models\Order;
use JWT;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Illuminate\Notifications\Notifiable;
use App\Notifications\AdminOrderHandled;
use Illuminate\Bus\Queueable;


class partController extends Controller
{

public function addOrder(Request $request)
{
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
        'status' => 'pending',
    ];

    $order = Order::create($data);
    $order->load('user');

    if (!$order) {
        return response()->json(['message' => 'Failed to create order'], 500);
    }

    $admin = User::where('role', 'admin')->first();
    if ($admin) {
        $admin->notify(new AdminOrderHandled($order, $order->status));
    }

    return response()->json([
        'message' => 'Order created successfully',
        'order' => $order
    ], 201);
}


    public function getOrders()
{
    $orders = Order::where('user_id', JWTAuth::user()->id)->get();

    return response()->json([
        'message' => 'Orders fetched successfully',
        'orders' => $orders
    ], 200);
}

public function updateOrder(Request $request  , $order_id)
{


    $request->validate([
        'item_name'=> 'required|string|exists:items,name',
        'details' => 'required',
    ]);

    $item = Item::where('name', $request->item_name)->first();

    if (!$item) {
        return response()->json(['message' => 'Item not found'], 404);
    }

    $userId = JWTAuth::user()->id;


    $order = Order::where('user_id', $userId)->first();

    if (!$order) {
        return response()->json(['message' => 'Order not found'], 404);
    }
    $order = Order::findOrFail($order_id);

    $order->item_name = $request->item_name;
    $order->item_id = $item->id;
    $order->details = $request->details;

    $order->save();

    return response()->json(['message' => 'Update information is successful']);
}


public function deleteOrder($order_id)
{
    $order = Order::find($order_id);

    if (!$order) {
        return response()->json(['message' => 'Order not found'], 404);
    }

    $order->delete();

    return response()->json(['message' => 'Delete is successful'], 200);
}
public function getNotifications()
{
    $user = auth()->user();
    return response()->json([
        'all' => $user->notifications,
        'unread' => $user->unreadNotifications,
        'unread_count' => $user->unreadNotifications->count(),
    ]);
}


}
