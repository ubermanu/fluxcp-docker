<?php

$userConfig = include __DIR__ . '/servers.php';

$dockerConfig = [
    0 => [
        'ServerName' => getenv('RO_SERVER_NAME'),
        'DbConfig' => [
            'Hostname' => getenv('DATABASE_HOST'),
            'Username' => getenv('DATABASE_USER'),
            'Password' => getenv('DATABASE_PASS'),
            'Database' => getenv('DATABASE_NAME'),
        ],
        'LogsDbConfig' => [
            'Hostname' => getenv('LOG_DATABASE_HOST'),
            'Username' => getenv('LOG_DATABASE_USER'),
            'Password' => getenv('LOG_DATABASE_PASS'),
            'Database' => getenv('LOG_DATABASE_NAME'),
        ],
        'LoginServer' => [
            'Address' => getenv('LOGIN_SERVER_HOST'),
        ],
        'CharMapServers' => [
            0 => [
                'ServerName' => getenv('RO_SERVER_NAME'),
                'CharServer' => [
                    'Address' => getenv('CHAR_SERVER_HOST'),
                ],
                'MapServer' => [
                    'Address' => getenv('MAP_SERVER_HOST'),
                ],
            ]
        ]
    ]
];

return array_replace_recursive($userConfig, $dockerConfig);
