<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;
use App\Notifications\OrderStatusChanged;
use App\Notifications\AdminOrderHandled;
use JWTFactory;
use JWTAuth;


class workercontroller extends Controller
{

    public function handleOrder(Request $request, $orderId)
{
    $validated = Validator::make($request->all(), [
        'status' => 'required|in:accepted,rejected'
    ]);

    if ($validated->fails()) {
        return response()->json(['errors' => $validated->errors()], 400);
    }

    $order = Order::find($orderId);

    if (!$order) {
        return response()->json(['message' => 'Order not found'], 404);
    }

    if (auth()->user()->role !== 'worker') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $order->status = $request->status;

    if ($request->status === 'accepted') {
        $order->worker_id = auth()->id();
    } else {

        $order->worker_id = null;
    }

    $order->save();


    $order->load('user', 'worker');


    $order->user->notify(new OrderStatusChanged($order, $request->status));


    $admin = User::where('role', 'admin')->first();
    if ($admin) {
        $admin->notify(new AdminOrderHandled($order, $request->status));
    }

    return response()->json([
        'message' => 'Order status updated successfully',
        'order' => $order
    ], 200);
}

public function getAcceptedOrdersByWorker()
{

    if (auth()->user()->role !== 'worker') {
        return response()->json(['message' => 'Unauthorized'], 403);
    }

    $workerId = auth()->id();


    $orders = Order::where('worker_id', $workerId)
                   ->where('status', 'accepted')
                   ->with('user', 'item')
                   ->get();

    return response()->json([
        'message' => 'Accepted orders retrieved successfully',
        'orders' => $orders
    ], 200);
}

}
