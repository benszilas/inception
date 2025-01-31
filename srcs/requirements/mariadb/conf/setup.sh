#!/bin/sh

# Read MySQL root password from Docker secrets
MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
MYSQL_USER_PASSWORD=$(cat "$MYSQL_USER_PASSWORD_FILE")


# Ensure proper ownership of MySQL data directory
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB in background to set up users
mysqld --skip-networking --user=mysql &
pid="$!"

# Secure database and create users
mysql -u root <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL
fi

# Shutdown temp database
mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec "$@"