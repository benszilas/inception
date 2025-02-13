FROM alpine:3.20
RUN apk update && apk add mariadb mariadb-client
CMD ["/bin/sh"]
