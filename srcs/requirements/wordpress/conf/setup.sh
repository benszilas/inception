#!/bin/sh

set -e

MYSQL_USER_PASSWORD=$(cat "$MYSQL_USER_PASSWORD_FILE")
WP_ADMIN_PASSWORD=$(cat "$WP_CREDENTIALS_FILE")

if [ -f /var/www/html/wp-config.php ]; then
    echo "WordPress already installed"
else

	wget -q https://wordpress.org/latest.tar.gz --no-check-certificate \
	&& tar -xzf latest.tar.gz --strip-components=1 -C /var/www/html \
	&& rm latest.tar.gz
    chown -R www-data:www-data /var/www/html

    wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

    wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_USER_PASSWORD"\
        --dbhost="$DB_HOST" --allow-root --path=/var/www/html

    wp core install --url=https://"$DOMAIN_NAME" --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email --allow-root

fi

exec "$@"