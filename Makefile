COMPOSE=docker-compose.yml

# Build des images Docker définies dans docker-compose.yml
build:
	docker-compose -f $(COMPOSE) build

# Démarrer les conteneurs
up:
	docker-compose -f $(COMPOSE) up -d

# Arrêter les conteneurs sans les supprimer
stop:
	docker-compose -f $(COMPOSE) stop

# Redémarrer les conteneurs
restart: stop up

# Supprimer les conteneurs et les réseaux, sans affecter les volumes ou images
down:
	docker-compose -f $(COMPOSE) down

# Nettoyer les conteneurs, réseaux et images associés
clean: down
	docker system prune -f

.PHONY: build up down stop restart clean