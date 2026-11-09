#!/bin/bash
set -e

echo "Checking if app key exists..."
if [ -z "$(php artisan config:get app.key 2>/dev/null)" ]; then
    echo "Generating application key..."
    php artisan key:generate
fi

echo "Running fresh database migrations and seeding..."
php artisan migrate:fresh --seed

echo "Starting PHP-FPM..."
exec php-fpm
