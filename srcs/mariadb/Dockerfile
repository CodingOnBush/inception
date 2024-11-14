# Utiliser une image de base Debian
FROM debian:bullseye

# Installer MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

# Copier les fichiers de configuration si nécessaire
COPY ./my_custom_config.cnf /etc/mysql/conf.d/

# Exposer le port pour MariaDB
EXPOSE 3306

# Commande par défaut pour démarrer MariaDB
CMD ["mysqld"]
