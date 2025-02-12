#!/bin/sh

cat <<-EOF > /var/www/html/index.html
    <html>
        <head>
            <title>Welcome to $DOMAIN_NAME</title>
        </head>
        <body>
            <h1>Welcome to $DOMAIN_NAME</h1>
            <p>This is the default web page for this server.</p>
            <p>The web server software is running but no content has been added, yet.</p>
        </body>
    </html>
EOF

SSL_CERT_FILE="/etc/nginx/ssl/$DOMAIN_NAME.crt"
SSL_KEY_FILE="/etc/nginx/ssl/$DOMAIN_NAME.key"

if [ ! -f /etc/nginx/nginx.conf.orig ]; then
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
fi

if [ ! -f "$SSL_CERT_FILE" || ! -f "$SSL_KEY_FILE" ]; then
    openssl req -new -x509 -nodes -out "$SSL_CERT_FILE" -keyout "$SSL_KEY_FILE"
fi

cat <<-EOF > /etc/nginx/nginx.conf
    user www-data;
    worker_processes auto;

    server {
        listen              443 ssl;
        server_name         "$DOMAIN_NAME";
        ssl_certificate     "$SSL_CERT_FILE";
        ssl_certificate_key "$SSL_KEY_FILE";
        ssl_protocols       TLSv1.2 TLSv1.3;

        location / {
            root /var/www/html;
            index.php index.html;
        }
    }
EOF

"$@"