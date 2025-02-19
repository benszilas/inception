FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql && chown -R mysql:mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql

COPY conf/setup.sh /tmp/setup.sh
COPY tools/healthcheck.sh /tmp/healthcheck.sh
RUN chmod +x /tmp/setup.sh && chmod +x /tmp/healthcheck.sh

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["mariadbd", "--user=mysql", "--port=3306"]