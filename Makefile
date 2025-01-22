nginx:
	docker build -t nginx ./dockerfiles/nginx
	docker run -d -p 80:80 nginx