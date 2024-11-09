COMPOSE=docker-compose.yml

# Build the Docker images defined in docker-compose.yml
build:
	docker-compose -f $(COMPOSE) build

# Start the containers
up:
	docker-compose -f $(COMPOSE) up -d

# Stop the containers without removing them
stop:
	docker-compose -f $(COMPOSE) stop

# Restart the containers
restart: stop up

# Remove the containers and networks, without affecting volumes or images
down:
	docker-compose -f $(COMPOSE) down

# Clean up containers, networks, and associated images
clean: down
	docker system prune -f

.PHONY: build up down stop restart clean