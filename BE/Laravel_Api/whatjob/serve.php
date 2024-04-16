<?php
$host = gethostbyname(gethostname());
$port = 7000;

echo "Starting Laravel development server: http://{$host}:{$port}/\n";

passthru("php artisan serve --host={$host} --port={$port}");
