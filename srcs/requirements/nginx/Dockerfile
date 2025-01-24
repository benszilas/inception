FROM debian:11.0 

RUN apt-get update && \
    apt-get install -y nginx 

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]