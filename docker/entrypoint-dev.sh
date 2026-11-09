#!/bin/bash
set -e

echo "Running fresh database migrations and seeding..."
php artisan migrate:fresh --seed

echo "Starting PHP-FPM..."
exec php-fpm
