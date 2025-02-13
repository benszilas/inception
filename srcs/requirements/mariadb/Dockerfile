FROM alpine:3.20

#https://wiki.alpinelinux.org/wiki/MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

#MariaDB needs this directory to function
RUN mkdir -p /run/mysqld /var/lib/mysql && chown -R mysql:mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql

COPY conf/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["mariadbd", "--user=mysql", "--port=3306"]

# CMD ["/bin/sh"]