# Base model
FROM debian:bullseye

# Mise à jour du système et installation de PHP, WordPress, et des dépendances
RUN apt update -y && apt upgrade -y \
    && apt install -y php7.3 php7.3-fpm php7.3-mysql wget curl mariadb-client

# Installer WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www \
    && cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# Copier le script de configuration automatique
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

# Exposer le port 9000 (port pour PHP-FPM)
EXPOSE 9000

# Exécuter le script de configuration et démarrer PHP-FPM
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
