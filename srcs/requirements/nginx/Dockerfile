FROM debian:bookworm 

RUN apt-get update && \
    apt-get install -y nginx 

COPY tools/index.html /usr/share/nginx/html/
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"] 