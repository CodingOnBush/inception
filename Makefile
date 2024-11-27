include ./srcs/.env

# Variables
COMPOSE_FILE	:=	srcs/docker-compose.yml

# Colors
RED				:=	"\033[0;31m"
GREEN			:=	"\033[0;32m"
YELLOW			:=	"\033[0;33m"
NC				:=	"\033[0m"

all: help

init:
	@echo $(GREEN)"Building the environment..."$(NC)
	mkdir -p /home/$(LOGIN)/data/database
	mkdir -p /home/$(LOGIN)/data/wp_files
	docker-compose -f $(COMPOSE_FILE) up -d --build

start:
	@echo $(GREEN)"Starting the environment..."$(NC)
	docker-compose -f $(COMPOSE_FILE) start

stop:
	@echo $(GREEN)"Stopping the environment..."$(NC)
	docker-compose -f $(COMPOSE_FILE) stop

down:
	@echo $(GREEN)"Stopping the environment..."$(NC)
	docker-compose -f $(COMPOSE_FILE) down

clean:
	@echo $(GREEN)"Cleaning the environment..."$(NC)
	docker-compose -f $(COMPOSE_FILE) down --rmi all --volumes
	docker system prune -af
	rm -rf /home/$(LOGIN)/data

re: clean init start
	@echo $(GREEN)"Rebuilding the project..."$(NC)

status:
	@echo $(GREEN)"Status of the containers..."$(NC)
	docker ps

help:
	@echo $(YELLOW)"Usage :"$(NC)
	@echo $(YELLOW)"  make...........: Display this help"$(NC)
	@echo $(YELLOW)"  make init......: Build the environment"$(NC)
	@echo $(YELLOW)"  make start.....: Start the environment"$(NC)
	@echo $(YELLOW)"  make stop......: Stop the environment"$(NC)
	@echo $(YELLOW)"  make down......: Stop and remove the environment"$(NC)
	@echo $(YELLOW)"  make clean.....: Remove all the containers and volumes"$(NC)
	@echo $(YELLOW)"  make re........: Rebuild the environment"$(NC)
	@echo $(YELLOW)"  make status....: Display the status of the containers"$(NC)

.PHONY: all init start stop down clean re status help