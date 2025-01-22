FROM debian:bookworm 

RUN apt-get update && \
    apt-get install -y nginx 

COPY index.html /usr/share/nginx/html/
COPY 

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"] 