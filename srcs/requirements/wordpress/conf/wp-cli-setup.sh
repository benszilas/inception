#!/bin/bash

wp core download --allow-root
wp config create \
	--dbname="$WORDPRESS_DB_NAME" \
	--dbuser="$WORDPRESS_DB_USER" \
	--dbpass="$WORDPRESS_DB_PASSWORD" \
	--dbhost="$WORDPRESS_DB_HOST" \
	--allow-root
wp core install \
	--url=http://localhost \
	--title="Hello World" \
	--admin_user="$WP_ADMIN" \
	--admin_password="$WP_ADMIN_PW" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--allow-root
wp user create "$WP_SECOND_USER" "$WP_SECOND_USER_PW" --allow-root

php-fpm