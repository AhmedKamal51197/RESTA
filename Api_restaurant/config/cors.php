<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    // 'paths' => ['api/*', 'sanctum/csrf-cookie'],

    // 'allowed_methods' => ['*'],

    // 'allowed_origins' => ['*'],

    // 'allowed_origins_patterns' => [],

    // 'allowed_headers' => ['*'],

    // 'exposed_headers' => [],

    // 'max_age' => 0,

    // 'supports_credentials' => false,
        /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://d...content-available-to-author-only...a.org/en-US/docs/Web/HTTP/CORS
    |
    */
 
    'paths' => ['api/*', 'sanctum/csrf-cookie'],
 
    'allowed_methods' => ['*'],  // Allow all HTTP methods
 
    'allowed_origins' => [
        'https://8ffe-197-38-191-128.ngrok-free.app',  // Your frontend URL
        'http://localhost',         // Allow from localhost
        'http://127.0.0.1',         // Allow from 127.0.0.1
        'http://localhost:3000',    // Typical port for React development server
        'http://127.0.0.1:3000',    // Typical port for React development server
        'https://f541-197-38-253-51.ngrok-free.app',
        'https://262eaa7cd83999cae1bb3041dba128c0.serveo.net'
        
        // Add other specific origins if necessary
    ],
 
    'allowed_origins_patterns' => [],  // Use this if you need pattern matching for origins
 
    'allowed_headers' => ['*'],  // Allow all headers
 
    'exposed_headers' => [],  // Specify any headers that need to be exposed
 
    'max_age' => 0,  // Cache duration for preflight requests
 
    'supports_credentials' => true,  // Enable credentials (cookies, authorization headers, etc.)


    'allowed_methods' => ['*'],


 

    'supports_credentials' =>true ,


];
