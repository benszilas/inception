FROM debian:11.0 

RUN apt-get update && \
    apt-get install -y nginx 

COPY conf/nginx.conf /etc/nginx/sites-available/default


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]