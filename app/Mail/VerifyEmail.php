<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class VerifyEmail extends Mailable
{
    use Queueable, SerializesModels;

    public $user;
    public $url;

    /**
     * Create a new message instance.
     *
     * @param  mixed  $user
     * @param  string  $url
     * @return void
     */
    public function __construct($user, $url)
    {
        $this->user = $user;
        $this->url = $url;
       // dd($url);

        // Set the sender email address and subject
        $this->from('sonbaty1937@gmail.com', 'RESTA');
        $this->subject('Verify Email');
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        // Use a predefined view for the email content
        return $this->view('emails.verify_email');
    }
}
