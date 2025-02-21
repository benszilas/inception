#!/bin/sh

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then

MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
MYSQL_USER_PASSWORD=$(cat "$MYSQL_USER_PASSWORD_FILE")

mariadb-install-db --user="$MYSQL_USER" --datadir=/var/lib/mysql

mariadbd --user="$MYSQL_USER" &
mariadb_pid=$!

while [ ! -S "/run/mysqld/mysqld.sock" ]; do
    echo "waiting for daemon to start..."
    sleep 1
done
echo "daemon started in background"

mariadb -u root <<-EOF
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
    ALTER USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    SHUTDOWN;
EOF

while ps ax | awk '{print $1}' | grep "$mariadb_pid" ; do
    echo "waiting for setup to finish..."
    sleep 1
done

echo "root and mysql user are set up"
fi

cat <<-EOF > /etc/my.cnf

    [mysqld]
    skip-networking=0
    skip-bind-address
    port=3306
EOF

exec "$@"
