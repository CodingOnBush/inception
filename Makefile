
# Set the project directory where the docker-compose.yml file resides.
PROJECT_DIR := ./srcs

all:
	cd $(PROJECT_DIR) && docker-compose up --build

# Target: up
# Start the Docker containers without rebuilding them.
up:
	cd $(PROJECT_DIR) && docker-compose up

# Target: down
# Stop and remove the Docker containers.
down:
	cd $(PROJECT_DIR) && docker-compose down

# Target: delete
# Remove unused Docker resources (images, containers, volumes, networks).
delete:
	cd $(PROJECT_DIR) && docker system prune -a

# Target: rm_volumes
# Remove all Docker volumes and associated containers.
rm_volumes:
	docker ps -aq | xargs -r docker rm -fv
	docker volume ls -q | xargs -r docker volume rm
# Target: rm_data
# Remove data directories used by the application.
rm_data:
	rm -rf /home/mos/data/wordpress/* && rm -rf /home/mos/data/mariadb/*
# Target: clean_all
# Stop and remove all Docker containers, volumes, networks, and images (both used and unused).
clean_all:
	cd $(PROJECT_DIR) && docker-compose down --volumes --remove-orphans
	docker network prune -f
	docker system prune -af --volumes
	docker container prune -f
	docker volume prune -f
	docker image prune -af
