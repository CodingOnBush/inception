# Variables
DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml
START_SCRIPT = ./srcs/tools/start.sh
CLEAN_SCRIPT = ./srcs/tools/clean.sh

# Cible par défaut : Démarrer le projet
all: start

# Démarrer le projet avec le script start.sh
start:
	@echo "Démarrage de l'infrastructure..."
	@$(START_SCRIPT)

# Arrêter tous les conteneurs
stop:
	@echo "Arrêt des conteneurs..."
	@$(DOCKER_COMPOSE) down

# Nettoyer l'environnement Docker
clean:
	@echo "Nettoyage complet de l'environnement Docker..."
	@$(CLEAN_SCRIPT)

# Rebuild complet
re:
	@echo "Reconstruction complète du projet..."
	@make clean
	@make start

# Afficher l'état des conteneurs
status:
	@echo "État des conteneurs actifs :"
	@docker ps

# Aide pour les commandes disponibles
help:
	@echo "Commandes disponibles dans le Makefile :"
	@echo "  make start    -> Démarre l'infrastructure avec docker-compose"
	@echo "  make stop     -> Arrête tous les conteneurs"
	@echo "  make clean    -> Nettoie l'environnement Docker"
	@echo "  make re       -> Reconstruit tout le projet"
	@echo "  make status   -> Affiche l'état des conteneurs actifs"
