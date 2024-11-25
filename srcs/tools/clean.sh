#!/bin/bash

# Arrêter et supprimer tous les conteneurs
echo "Arrêt et suppression de tous les conteneurs..."
docker stop $(docker ps -qa) 2>/dev/null
docker rm $(docker ps -qa) 2>/dev/null

# Supprimer tous les volumes Docker
echo "Suppression de tous les volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null

# Supprimer toutes les images Docker non utilisées
echo "Suppression de toutes les images non utilisées..."
docker rmi -f $(docker images -qa) 2>/dev/null

# Supprimer tous les réseaux Docker non utilisés
echo "Suppression de tous les réseaux non utilisés..."
docker network rm $(docker network ls -q) 2>/dev/null

# Nettoyage terminé
echo "Nettoyage Docker terminé !"
