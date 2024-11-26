DOCKER_COMPOSE	:=	docker-compose -f srcs/docker-compose.yml
START_SCRIPT	:=	./srcs/tools/start.sh
CLEAN_SCRIPT	:=	./srcs/tools/clean.sh

RED		:=	\033[0;31m
GREEN	:=	\033[0;32m
YELLOW	:=	\033[0;33m
NC		:=	\033[0m

all: start

start:
	@echo $(GREEN)"Starting the environment..."$(NC)
	@$(START_SCRIPT)

stop:
	@echo $(RED)"Stopping the environment..."$(NC)
	@$(DOCKER_COMPOSE) down

clean:
	@echo $(YELLOW)"Cleaning the environment..."$(NC)
	@$(CLEAN_SCRIPT)

re:
	@echo $(YELLOW)"Rebuilding the project..."$(NC)
	@make clean
	@make start

status:
	@echo $(YELLOW)"Status of the containers..."$(NC)
	@docker ps

help:
	@echo $(YELLOW)"Usage :"$(NC)
	@echo $(YELLOW)"  make start    -> Start all the containers"$(NC)
	@echo $(YELLOW)"  make stop     -> Stop all the containers"$(NC)
	@echo $(YELLOW)"  make clean    -> Clean the environment"$(NC)
	@echo $(YELLOW)"  make re       -> Rebuid the project"$(NC)
	@echo $(YELLOW)"  make status   -> Display the status of the containers"$(NC)
	@echo $(YELLOW)"  tips : docker exec -it <containerID> /bin/bash"$(NC)

.PHONY: all start stop clean re status help