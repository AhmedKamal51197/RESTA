<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class EmailVerificationNotification extends Notification
{
    use Queueable;
    protected $url;

    /**
     * Create a new notification instance.
     */
    public function __construct($url)
    {
        $this->url=$url;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
                    ->subject('Verify Email Address')
                    ->line("Dear $notifiable->name")
                    ->line('Thank you for signing up with Our RESTA Site ! To ensure the security of your account and to keep you informed about our latest updates and offerings ,we need to verify your email address.')
                    ->action('Notification Action', $this->url)
                    ->line("if you didn't create an account, no further action is required from you.");
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}
