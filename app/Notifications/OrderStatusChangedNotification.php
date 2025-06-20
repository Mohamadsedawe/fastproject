<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class OrderStatusChangedNotification extends Notification
{
    use Queueable;

    protected $order;
    protected $status;

    public function __construct($order, $status)
    {
        $this->order = $order;
        $this->status = $status;
    }

    public function via($notifiable)
    {
        return ['mail', 'database'];
    }

    public function toMail($notifiable)
    {
        $user = $this->order->user;
        $worker = $this->order->worker;

        $statusText = $this->status === 'accepted' ? 'مقبول' : 'مرفوض';

        return (new MailMessage)
            ->subject('تحديث حالة الطلب')
            ->greeting('مرحباً،')
            ->line("تم تحديث حالة الطلب رقم #{$this->order->id} إلى: {$statusText}")
            ->line("مقدم الطلب: {$user->firstname} {$user->lastname}")
            ->line("العامل المسؤول: " . ($worker ? $worker->firstname . ' ' . $worker->lastname : 'غير محدد'))
            ->salutation('إدارة النظام');
    }

    public function toArray($notifiable)
    {
        return [
            'order_id' => $this->order->id,
            'status' => $this->status,
            'user_name' => $this->order->user->firstname . ' ' . $this->order->user->lastname,
            'worker_name' => $this->order->worker ? $this->order->worker->firstname . ' ' . $this->order->worker->lastname : null,
            'message' => "تم تحديث حالة الطلب إلى {$this->status}",
        ];
    }
}
