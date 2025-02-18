FROM alpine:3.20

ARG DOMAIN_NAME
ARG USER

RUN apk update && apk add --no-cache nginx openssl gettext-envsubst

RUN mkdir -p /etc/nginx/ssl

COPY ./conf/setup.sh /tmp/setup.sh
COPY ./conf/${DOMAIN_NAME}.conf /tmp/${DOMAIN_NAME}.conf
COPY /home/${USER}/data/cert/${DOMAIN_NAME}.crt /etc/nginx/ssl/${DOMAIN_NAME}.crt
COPY /home/${USER}/data/cert/${DOMAIN_NAME}.key /etc/nginx/ssl/${DOMAIN_NAME}.key

RUN chmod +x /tmp/setup.sh && mkdir -p /etc/nginx/http.d \
&& chown -R nginx:nginx /etc/nginx/http.d && chmod +r /etc/nginx/ssl/*

ENTRYPOINT [ "/tmp/setup.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]
