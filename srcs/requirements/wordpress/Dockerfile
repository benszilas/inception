ARG PHP_V="7.3"

FROM alpine:3.11

RUN apk update && apk upgrade && apk add --no-cache php php-fpm

COPY ./conf/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

CMD ["/tmp/setup.sh"]