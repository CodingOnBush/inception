
# Set the project directory where the docker-compose.yml file resides.
CMD = docker-compose -f ./srcs/docker-compose.yml

all: build up

build:
	$(CMD) up --build

# Target: up
# Start the Docker containers without rebuilding them.
up:
	$(CMD) up

# Target: down
# Stop and remove the Docker containers.
down:
	$(CMD) down

# Target: delete
# Remove unused Docker resources (images, containers, volumes, networks).
delete:
	docker system prune -a

init:
	@echo "Creating data directories..."
	mkdir -p /home/mos/data/wp && mkdir -p /home/mos/data/db

# Target: rm_volumes
# Remove all Docker volumes and associated containers.
rm_volumes:
	docker ps -aq | xargs -r docker rm -fv
	docker volume ls -q | xargs -r docker volume rm
# Target: rm_data
# Remove data directories used by the application.
rm_data:
	rm -rf /home/mos/data/wp/* && rm -rf /home/mos/data/db/*
# Target: clean_all
# Stop and remove all Docker containers, volumes, networks, and images (both used and unused).
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
	@echo "  all          Build and start the Docker containers."
	@echo "  build        Build the Docker containers."
	@echo "  up           Start the Docker containers."
	@echo "  down         Stop and remove the Docker containers."
	@echo "  delete       Remove unused Docker resources (images, containers, volumes, networks)."
	@echo "  init         Create data directories."
	@echo "  rm_volumes   Remove all Docker volumes and associated containers."
	@echo "  rm_data      Remove data directories used by the application."
	@echo "  clean_all    Stop and remove all Docker containers, volumes, networks, and images (both used and unused)."
	@echo "  help         Display this help message."
	@echo ""