CMD = docker-compose -f ./srcs/docker-compose.yml

all: build up

build:
	$(CMD) build

up:
	$(CMD) up -d

stop:
	$(CMD) stop

down:
	$(CMD) down

delete:
	docker system prune -a

init:
	@echo "Creating data directories..."
	mkdir -p /home/momrane/data/wp && mkdir -p /home/momrane/data/db

remove_all_volumes:
	docker ps -aq | xargs -r docker rm -fv
	docker volume ls -q | xargs -r docker volume rm

remove_all_data:
	rm -rf /home/momrane/data/wp/* && rm -rf /home/momrane/data/db/*

clean_all:
	$(CMD) down --volumes --remove-orphans
	docker network prune -f
	docker system prune -af --volumes
	docker container prune -f
	docker volume prune -f
	docker image prune -af

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  all        - Build and start the containers"
	@echo "  build      - Build the containers"
	@echo "  up         - Start the containers"
	@echo "  stop       - Stop the containers"
	@echo "  down       - Stop and remove the containers"
	@echo "  delete     - Remove all unused containers, networks, images, and volumes"
	@echo "  init       - Create data directories"
	@echo "  remove_all_volumes - Remove all volumes"
	@echo "  remove_all_data    - Remove all data"
	@echo "  clean_all  - Stop and remove all containers, networks, images, and volumes"
	@echo "  help       - Display this help message"
	@echo ""