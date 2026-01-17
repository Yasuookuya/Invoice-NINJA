#!/bin/sh
set -e

# 1) Create required dirs explicitly (no brace expansion)
mkdir -p /var/www/app/storage/logs
mkdir -p /var/www/app/storage/framework/cache
mkdir -p /var/www/app/storage/framework/sessions
mkdir -p /var/www/app/storage/framework/views
mkdir -p /var/www/app/bootstrap/cache

# 2) Make them writable by the app user
chown -R www-data:www-data /var/www/app/storage /var/www/app/bootstrap/cache || true

# 3) Laravel prep (ok if run multiple times)
php artisan optimize || true
php artisan migrate --force || true

# 4) Hand off to the standard supervisor (nginx + php-fpm)
exec supervisord -c /etc/supervisord.conf
