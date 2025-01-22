nginx:
	docker build -t nginx ./srcs/requirements/nginx
	docker run -d -p 443:443 -v server.key:/etc/nginx/ssl/server.key:ro -v server.crt:/etc/nginx/ssl/server.crt:ro nginx