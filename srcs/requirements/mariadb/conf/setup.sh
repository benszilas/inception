#!/bin/sh

# Read MySQL root password from Docker secrets
MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
MYSQL_USER_PASSWORD=$(cat "$MYSQL_USER_PASSWORD_FILE")

if [ ! -d "/var/lib/mysql/mysql" ]; then
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB in background to set up users
mariadbd --user=mysql --skip-networking &

# Secure database and create users
mariadb -u root <<-EOF
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOF
fi

# Shutdown temp database
mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown 

exec "$@"