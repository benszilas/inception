FROM alpine:3.20

ARG DOMAIN_NAME

RUN apk update && apk add --no-cache nginx openssl gettext-envsubst

RUN mkdir -p /etc/nginx/ssl

COPY ./conf/setup.sh /tmp/setup.sh
COPY ./conf/nginx.conf /tmp/nginx.conf
COPY ./tools/${DOMAIN_NAME}.crt /etc/nginx/ssl/${DOMAIN_NAME}.crt
COPY ./tools/${DOMAIN_NAME}.key /etc/nginx/ssl/${DOMAIN_NAME}.key

RUN chmod +x /tmp/setup.sh
# RUN adduser -S www-data -G www-data && chown -R www-data:www-data /etc/nginx && chmod +x /tmp/setup.sh
# #/var/lib/nginx maybe too? lets see

# USER www-data

ENTRYPOINT [ "/tmp/setup.sh" ]
CMD ["nginx", "-g", "daemon off;"]
