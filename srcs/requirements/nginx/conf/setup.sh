#!/bin/sh

if [ ! -d "/etc/ssl/private" ]; then
	mkdir -p /etc/ssl/private
fi

#since this is a school project, we are just signing a new certificate each time
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
-subj "/C=AT/ST=Wien/L=Wien/O=42/CN=$DOMAIN_NAME" \
-keyout /etc/ssl/private/"$DOMAIN_NAME".key  -out /etc/ssl/private/"$DOMAIN_NAME".crt

envsubst '$DOMAIN_NAME' < /tmp/"$DOMAIN_NAME".conf > /etc/nginx/http.d/"$DOMAIN_NAME".conf
echo server config copied with status: $?

"$@"