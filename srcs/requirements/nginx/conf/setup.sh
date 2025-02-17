#!/bin/sh

envsubst '$SSL_CERT_FILE $SSL_KEY_FILE $DOMAIN_NAME' < /tmp/"$DOMAIN_NAME".conf > /etc/nginx/http.d/"$DOMAIN_NAME".conf
echo server config copied with status: $?

#self-signed certificate for testing purposes - therefore ok to use this backup
if [ ! -f "$SSL_CERT_FILE" ] || [ ! -f "$SSL_KEY_FILE" ]; then
    echo "Generating self-signed certificate..."
	rm -rf "$SSL_CERT_FILE" "$SSL_KEY_FILE"
    openssl req -new -x509 -nodes -out "$SSL_CERT_FILE" -keyout "$SSL_KEY_FILE"
else
    echo "Using provided certificate..."
fi

"$@"