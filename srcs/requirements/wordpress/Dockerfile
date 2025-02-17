FROM alpine:3.20

#install php and php-fpm and wget
RUN apk update && apk upgrade && apk add --no-cache php php-fpm php-phar php-mysqli wget \
php-json php-opcache php-curl php-xml php-mbstring php-gd php-zip php-tokenizer php-ctype php-dom

#create necessary directory and user
RUN mkdir -p /var/www/html && adduser -S www-data -G www-data \
&& chown -R www-data:www-data /var/www/html && chown -R www-data:www-data /var/log/php83 && chmod -R 755 /var/www/html
WORKDIR /var/www/html

#create the wp-config.php file inside the script using wp-cli and create wordpress admin 
COPY ./conf/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh
# USER www-data

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["php-fpm83", "-F"]
