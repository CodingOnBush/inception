#!/bin/sh

# Script d'installation et de configuration pour MariaDB

# Variables d'environnement nécessaires
DB_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-root_password}
DB_NAME=${MYSQL_DATABASE:-wordpress}
DB_USER=${MYSQL_USER:-wp_user}
DB_PASSWORD=${MYSQL_PASSWORD:-wp_password}

# Démarrer le service MariaDB
echo "Démarrage de MariaDB..."
mariadbd --user=mysql --datadir=/var/lib/mysql &

# Attendre que MariaDB soit prêt
echo "Attente de la disponibilité de MariaDB..."
until mariadb --protocol TCP -uroot -e "SELECT 1;" > /dev/null 2>&1; do
  sleep 1
done

echo "MariaDB est prêt !"

# Configuration initiale
echo "Configuration de la base de données..."
mariadb -uroot <<EOF
-- Définir le mot de passe root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';

-- Créer la base de données
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Créer l'utilisateur et lui donner des privilèges
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';

-- Appliquer les changements
FLUSH PRIVILEGES;
EOF

echo "La base de données a été configurée avec succès !"

# Maintenir le processus en avant-plan
wait
