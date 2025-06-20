<?php

// app/Notifications/OrderStatusChanged.php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use App\Models\Order;

class OrderStatusChanged extends Notification
{
    use Queueable;

    protected $order;
    protected $status;

    public function __construct(Order $order, $status)
    {
        $this->order = $order;
        $this->status = $status;
    }

    public function via($notifiable)
    {
        return ['database', 'mail'];
    }

    public function toMail($notifiable)
    {
        return (new MailMessage)
            ->subject('Your Order Status Changed')
            ->line("Your order status is now: {$this->status}")
            ->line("Worker: " . ($this->order->worker ? $this->order->worker->name : 'No worker assigned yet'))
            ->line("Order details: {$this->order->details}");
    }

    public function toArray($notifiable)
    {
        return [
            'order_id' => $this->order->id,
            'status' => $this->status,
            'worker' => $this->order->worker ? [
                'id' => $this->order->worker->id,
                'name' => $this->order->worker->name,
            ] : null,
            'details' => $this->order->details,
        ];
    }
}
