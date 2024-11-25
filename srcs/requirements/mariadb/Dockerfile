# Utiliser Alpine comme base (penultième version stable)
FROM alpine:3.18

# Installer MariaDB et les outils nécessaires
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    bash \
    && rm -rf /var/cache/apk/*

# Créer les dossiers nécessaires pour MariaDB
RUN mkdir -p /var/lib/mysql /run/mysqld /etc/mysql/conf.d && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Copier le fichier de configuration personnalisé
COPY conf/my.cnf /etc/mysql/my.cnf

# Copier le script d'installation
COPY tools/setup_db.sh /setup_db.sh

# Donner les permissions d'exécution au script
RUN chmod +x /setup_db.sh

# Exposer le port 3306 pour MariaDB
EXPOSE 3306

# Commande d'entrée pour lancer MariaDB via le script
CMD ["/setup_db.sh"]
