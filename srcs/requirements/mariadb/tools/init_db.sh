#!/bin/bash

# Démarrer le service MySQL
service mysql start

# Créer la base de données et les utilisateurs #
# Create database
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
# Create user
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# Grant privileges
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
# Modify root user
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# Refresh privileges
mysql -e "FLUSH PRIVILEGES;"

# Éteindre le service MySQL pour le relancer en mode sécurisé
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Lancer MySQL en mode sécurisé
exec mysqld_safe
