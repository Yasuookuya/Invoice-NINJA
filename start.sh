#!/bin/sh
set -e

# Prepare Laravel dirs
mkdir -p /var/www/app/storage/logs \
         /var/www/app/storage/framework/cache \
         /var/www/app/storage/framework/sessions \
         /var/www/app/storage/framework/views \
         /var/www/app/bootstrap/cache

chown -R www-data:www-data /var/www/app/storage /var/www/app/bootstrap/cache || true

# DO NOT optimize before DB is reachable
php artisan migrate --force || true

# Now it's safe
php artisan optimize || true

php-fpm -D
exec nginx -g 'daemon off;'
