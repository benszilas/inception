#!/bin/sh

MYSQL_USER_PASSWORD=$(cat "$MYSQL_USER_PASSWORD_FILE")
WP_ADMIN_PASSWORD=$(cat "$WP_CREDENTIALS_FILE")

wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_USER_PASSWORD" \
    --dbhost="$DB_HOST"

wp core install --url=https://"$DOMAIN_NAME" --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email

exec "$@"