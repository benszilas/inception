FROM alpine:3.20

#install php and php-fpm and wget
RUN apk update && apk upgrade && apk add --no-cache php php-fpm wget

#install wordpress using wget
RUN wget https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz -C /var/www/html && rm latest.tar.gz \
&& chown -R www-data:www-data /var/www/html/wordpress

#install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

#create the wp-config.php file inside the script using wp-cli and create wordpress admin and user
COPY ./conf/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["php-fpm"]
