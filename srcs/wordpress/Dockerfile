FROM alpine:3.20

RUN apk update && apk upgrade && apk add --no-cache php php-fpm php-phar php-mysqli wget \
php-json php-opcache php-curl php-xml php-mbstring php-gd php-zip php-tokenizer php-ctype php-dom

RUN mkdir -p /var/www/html && adduser -S www-data -G www-data \
&& chown -R www-data:www-data /var/www/html && chown -R www-data:www-data /var/log/php83 && chmod -R 755 /var/www/html
WORKDIR /var/www/html

COPY ./conf/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["php-fpm83", "-F"]
