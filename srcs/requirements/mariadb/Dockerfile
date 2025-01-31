FROM alpine:3.11

#https://wiki.alpinelinux.org/wiki/MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

#MariaDB needs this directory to function
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY conf/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["mysqld", "--user=mysql"]
