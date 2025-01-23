FROM debian:v11 

RUN apt-get update && \
    apt-get install -y nginx 

COPY tools/index.html /usr/share/nginx/html/
COPY tools/server.crt /usr/share/nginx/html/
COPY tools/server.key /usr/share/nginx/html/
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"] 