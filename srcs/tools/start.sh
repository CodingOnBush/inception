#!/bin/bash

echo "Cleaning up the Docker environment..."
@./srcs/tools/clean.sh

echo "Building and starting the containers..."
@docker-compose -f srcs/docker-compose.yml up --build -d

echo "Checking the status of the containers..."
@docker ps

URL=$(grep WP_FULL_URL ./srcs/.env | cut -d '=' -f2)
@echo ""
@echo "Your infrastructure is ongoing..."
@echo "Access the services through the following URLs:${URL}"
@echo "To check the logs of a service, use: docker logs <container_name>"
@echo "To stop the services, use: make stop"
@echo "If you need help, use: make help"
