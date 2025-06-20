<?php

use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class NewOrderNotification extends Notification implements ShouldBroadcast
{
    protected $order;

    public function __construct($order)
    {
        $this->order = $order;
        // تأكد من تحميل علاقة اليوزر
        $this->order->load('user');
    }

    public function via($notifiable)
    {
        return ['database', 'broadcast'];
    }

    public function toDatabase($notifiable)
    {
        return [
            'order_id' => $this->order->id,
            'item_name' => $this->order->item_name,
            'user_name' => $this->order->user ? $this->order->user->firstname . ' ' . $this->order->user->lastname : 'غير معروف',
            'status' => $this->order->status,
            'message' => 'طلب جديد مقدم من ' . ($this->order->user ? $this->order->user->firstname : 'مستخدم مجهول'),
        ];
    }

    public function toBroadcast($notifiable)
    {
        return new BroadcastMessage([
            'order_id' => $this->order->id,
            'item_name' => $this->order->item_name,
            'user_name' => $this->order->user ? $this->order->user->firstname . ' ' . $this->order->user->lastname : 'غير معروف',
            'status' => $this->order->status,
            'message' => 'طلب جديد مقدم من ' . ($this->order->user ? $this->order->user->firstname : 'مستخدم مجهول'),
        ]);
    }

    public function broadcastOn()
    {
        // تأكد من تحديد القناة بشكل صحيح، هنا ترسل للآدمن
        return ['private-admin']; // أو حسب تعريف قنوات البث عندك
    }

    public function broadcastAs()
    {
        return 'new.order.notification';
    }
}
