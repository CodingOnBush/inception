# Utiliser une image de base Debian
FROM debian:bullseye

# Installer Apache, PHP, et les extensions nécessaires pour WordPress
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mysql wget tar && \
    apt-get clean

# Télécharger WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    rm -rf latest.tar.gz wordpress

# Exposer le port pour Apache
EXPOSE 80

# Commande par défaut pour démarrer Apache
CMD ["apachectl", "-D", "FOREGROUND"]
