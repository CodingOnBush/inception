# Utiliser une image de base Debian
FROM debian:bullseye

# Installer MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

# Exposer le port 3306 pour la base de données
EXPOSE 3306

# Démarrer MariaDB
CMD ["mysqld"]
