<?php

$userConfig = include __DIR__ . '/application.php';

$dockerConfig = [
    'ServerAddress' => 'localhost',
    'BaseURI' => getenv('BASE_PATH'),
    'InstallerPassword' => getenv('INSTALLER_PASSWORD'),
    'SiteTitle' => getenv('SITE_TITLE'),
];

return array_replace_recursive($userConfig, $dockerConfig);
