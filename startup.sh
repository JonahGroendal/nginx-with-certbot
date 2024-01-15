#!/bin/sh

# Start nginx in the background
service nginx start

# Wait for reverse proxy to see us
sleep 6

# Run certbot
if [ "$STAGING" = "true" ]; then
    certbot --nginx \
        --non-interactive \
        --register-unsafely-without-email \
        --agree-tos \
        --redirect \
        --keep-until-expiring \
        --staging \
        -d "$DOMAINS" >> /proc/1/fd/1 2>&1
else
    certbot --nginx \
        --non-interactive \
        --register-unsafely-without-email \
        --agree-tos \
        --redirect \
        --keep-until-expiring \
        -d "$DOMAINS" >> /proc/1/fd/1 2>&1
fi

# Stop the background Nginx service
service nginx stop

# Edit generated nginx config to work behind tcp reverse proxy
# only proceed if we're behind a reverse proxy
if [ "$USING_REVERSE_PROXY" = "true" ]; then
  /reconfigure.sh
fi

# Start Nginx in the foreground
nginx -g 'daemon off;'
