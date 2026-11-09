#!/bin/bash
set -e

echo "Running database migrations..."
php artisan migrate --force

echo "Starting PHP-FPM..."
exec php-fpm
