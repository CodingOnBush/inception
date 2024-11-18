# Utiliser une image de base Debian
FROM debian:bullseye

# Installer PHP, PHP-FPM, et les extensions nécessaires
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql wget tar && \
    apt-get clean

# Télécharger WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
	mkdir -p /var/www/html && \
    mv wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    rm -rf latest.tar.gz wordpress

# Exposer le port utilisé par PHP-FPM
EXPOSE 9000

# Commande par défaut pour démarrer php-fpm
CMD ["php-fpm", "-F"]
