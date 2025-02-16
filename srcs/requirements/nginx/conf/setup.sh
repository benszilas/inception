#!/bin/sh

cat <<-EOF > /var/www/html/index.html
    <html>
        <head>
            <title>Welcome to $DOMAIN_NAME</title>
        </head>
        <body>
            <p>This is the fallback web page for this server.</p>
            <p>The web server is running but wordpress files are not reachable.</p>
        </body>
    </html>
EOF

if [ ! -f /etc/nginx/nginx.conf.orig ]; then
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
fi

envsubst '$SSL_CERT_FILE $SSL_KEY_FILE $DOMAIN_NAME' < /tmp/nginx.conf > /etc/nginx/nginx.conf

if [ ! -f "$SSL_CERT_FILE" ] || [ ! -f "$SSL_KEY_FILE" ]; then
	rm -rf "$SSL_CERT_FILE" "$SSL_KEY_FILE"
    openssl req -new -x509 -nodes -out "$SSL_CERT_FILE" -keyout "$SSL_KEY_FILE"
fi

"$@"