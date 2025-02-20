#!/bin/sh

set -e

MYSQL_USER_PASSWORD=$(cat "$MYSQL_USER_PASSWORD_FILE")
WP_ADMIN_PASSWORD=$(cat "$WP_CREDENTIALS_FILE")

if [ "$PORT_NO" = "443" ]; then
    SITEURL="https://$DOMAIN_NAME"
else
    SITEURL="https://$DOMAIN_NAME:$PORT_NO"
fi

# Install WordPress-CLI
wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --no-check-certificate && chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp

# Install and configure WordPress - this config will be saved in persistent volume
if [ -f /var/www/html/wp-config.php ]; then
    echo "WordPress already installed"
else

	wget -q https://wordpress.org/latest.tar.gz --no-check-certificate && tar -xzf latest.tar.gz --strip-components=1 -C /var/www/html \
	&& rm latest.tar.gz
    chown -R www-data:www-data /var/www/html

    wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_USER_PASSWORD"\
        --dbhost="$DB_HOST" --allow-root --path=/var/www/html

    wp core install --url="$SITEURL" --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email --allow-root

fi

#if the host or port is changed in the environment variables, update the siteurl in the persistent database
CURRENT_URL=$(wp option get siteurl --allow-root --path=/var/www/html)
if [ "$SITEURL" != "$CURRENT_URL" ]; then
	wp option update siteurl "$SITEURL" --allow-root --path=/var/www/html
	wp option update home "$SITEURL" --allow-root --path=/var/www/html
	echo "Site URL updated to $SITEURL"
fi

# html page I used for troubleshooting under SITEURL/index.html
if [ ! -f /var/www/html/index.html ]; then
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
fi

#php-fpm listens on port 9000 in the docker network
sed -i 's/^listen = .*/listen = 9000/' /etc/php83/php-fpm.d/www.conf

exec "$@"