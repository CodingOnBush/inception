COMPOSE_FILE	:=	srcs/docker-compose.yml
RED				:=	"\033[0;31m"
GREEN			:=	"\033[0;32m"
YELLOW			:=	"\033[0;33m"
NC				:=	"\033[0m"

all: help

build:
	@echo $(GREEN)"Building the environment..."$(NC)
	docker-compose -f $(COMPOSE_FILE) build

up:
	@echo $(GREEN)"Starting the environment..."$(NC)
	docker-compose -f $(COMPOSE_FILE) up -d

down:
	@echo $(GREEN)"Stopping the environment..."$(NC)
	docker-compose -f $(COMPOSE_FILE) down

clean: down
	@echo $(GREEN)"Cleaning the environment..."$(NC)
	docker stop $(docker ps -qa)
	docker rm $(docker ps -qa)
	docker rmi -f $(docker images -qa)
	docker volume rm $(docker volume ls -q)
	docker network rm $(docker network ls -q)
	@echo $(GREEN)"Docker clean done!"$(NC)

re: down build up
	@echo $(GREEN)"Rebuilding the project..."$(NC)

status:
	@echo $(GREEN)"Status of the containers..."$(NC)
	docker ps

help:
	@echo $(YELLOW)"Usage :"$(NC)
	@echo $(YELLOW)"  make...........: Display this help"$(NC)
	@echo $(YELLOW)"  make build.....: Build the project"$(NC)
	@echo $(YELLOW)"  make up........: Start the project"$(NC)
	@echo $(YELLOW)"  make down......: Stop the project"$(NC)
	@echo $(YELLOW)"  make clean.....: Stop and remove the project"$(NC)
	@echo $(YELLOW)"  make re........: Rebuild the project"$(NC)
	@echo $(YELLOW)"  make status....: Display the status of the containers"$(NC)

.PHONY: all build up down clean re status help