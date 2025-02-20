#!/bin/sh

MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
mysqladmin ping -hlocalhost -uroot -p"${MYSQL_ROOT_PASSWORD}" --silent