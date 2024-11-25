#!/bin/bash

# Nettoyer l'environnement Docker avant de démarrer
# echo "Nettoyage de l'environnement Docker..."
# ./srcs/tools/clean.sh

# Construire et lancer les conteneurs
# echo "Construction et démarrage des services Docker..."
# docker-compose -f srcs/docker-compose.yml up --build -d

# Vérifier l'état des conteneurs
# echo "Vérification de l'état des conteneurs..."
# docker ps

# Afficher les URL importantes
pwd
DOMAIN=$(grep WP_FULL_URL ./srcs/.env | cut -d '=' -f2)
echo ""
echo "Votre infrastructure est en cours d'exécution !"
echo "Accédez à votre site WordPress via : $WP_FULL_URL"
echo "Pour voir les logs d'un service, utilisez : docker logs <nom_du_conteneur>"
echo "Pour arrêter tous les conteneurs : docker-compose -f srcs/docker-compose.yml down"
