# inception

This is my first try at setting up a LEMP stack the hard way, without pre-built images besides an Alpine base image.

Its a 42 school project to host a wordpress site :

• A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.

• A Docker container that contains WordPress + php-fpm.

• A Docker container that contains MariaDB.

• A volume that contains the WordPress database.

• A second volume that contains the WordPress website files.

• A docker-network that establishes the connection between containers.

## 1. you need to create the passwords of your choice for docker secrets. 

```sh
#make the secrets directory in the root of this repo
mkdir secrets; \
echo -n "your-db-root-password" > secrets/db_root_password.txt; \
echo -n "your-db-non-root-password" > secrets/db_password.txt; \
echo -n "your-wordpress-admin-password" > secrets/credentials.txt
```

## 2. Edit the environment file .env.example for docker-compose with the values of your choice

then copy .env.example in .env

```sh
cp .env.example .env
```

## 3. start the services
```sh
docker-compose up -d
```

Using a self-signed TLS/SSL certificate - site available by default at https://localhost:8443

For a custom domain name edit DOMAIN_NAME in the .env file and /etc/hosts 
(and remove / rebuild the images if they are already built)
