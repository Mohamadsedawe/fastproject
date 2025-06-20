<?php

// app/Notifications/AdminOrderHandled.php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use App\Models\Order;

class AdminOrderHandled extends Notification
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
        return ['database', 'mail'];  // تستخدم DB و البريد، يمكنك تعديلها حسب الحاجة
    }

    public function toMail($notifiable)
    {
        $message = (new MailMessage)
            ->subject('New Order Notification')
            ->line("Order status: {$this->status}")
            ->line("User: {$this->order->user->name} ({$this->order->user->email})")
            ->line("Order details: {$this->order->details}");

        if ($this->order->worker) {
            $message->line("Worker: {$this->order->worker->name} ({$this->order->worker->email})");
        }

        return $message;
    }

    public function toArray($notifiable)
    {
        return [
            'order_id' => $this->order->id,
            'status' => $this->status,
            'user' => [
                'id' => $this->order->user->id,
                'name' => $this->order->user->name,
                'email' => $this->order->user->email,
            ],
            'worker' => $this->order->worker ? [
                'id' => $this->order->worker->id,
                'name' => $this->order->worker->name,
                'email' => $this->order->worker->email,
            ] : null,
            'details' => $this->order->details,
        ];
    }
}
