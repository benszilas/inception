FROM alpine:3.20

ARG DOMAIN_NAME

RUN apk update && apk add --no-cache nginx openssl gettext-envsubst

COPY ./conf/setup.sh /tmp/setup.sh
COPY ./conf/localhost.conf /tmp/${DOMAIN_NAME}.conf

RUN chmod +x /tmp/setup.sh \
&& mkdir -p /etc/nginx/http.d \
&& chown -R nginx:nginx /etc/nginx/http.d

ENTRYPOINT [ "/tmp/setup.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]
