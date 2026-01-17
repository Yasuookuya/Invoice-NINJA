FROM invoiceninja/invoiceninja:5

USER root

# Install PostgreSQL build deps and PHP extensions
RUN apk add --no-cache postgresql-dev \
 && docker-php-ext-install pdo_pgsql pgsql

# Install nginx
RUN apk add --no-cache nginx

# Nginx config
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/bin/sh", "/start.sh"]
