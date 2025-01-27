#!/bin/bash

wp core download
wp config create --dbname=wp_db --dbuser=wp_user --dbpass=wp_password --dbhost=db
wp core install \
	--url="http://localhost:8080" \
	--title="Hello World" \
	--admin_user="admin" \
	--admin_password="strongpassword" \
	--admin_email="admin@example.com"