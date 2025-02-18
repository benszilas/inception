
up:
	cd srcs && docker-compose up -d
	
upf:
	cd srcs && docker-compose up

re: down up

down:
	cd srcs && docker-compose down

remove: down
	cd srcs && docker image prune -a

.PHONY: up re down remove