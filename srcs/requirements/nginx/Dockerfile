FROM alpine:3.20

RUN apk update && apk add nginx openssl

RUN mkdir -p /etc/nginx/ssl

COPY ./conf/setup.sh /tmp/setup.sh 

RUN adduser -S www-data -G www-data && chown -R www-data:www-data /etc/nginx && chmod +x /tmp/setup.sh
#/var/lib/nginx maybe too? lets see

USER www-data

ENTRYPOINT [ "/tmp/setup.sh" ]
CMD [ "rc-service", "nginx", "start" ]
