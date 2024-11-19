# Utiliser une image de base Debian
FROM debian:11-slim

# Installer MariaDB
RUN sudo apt-get update && \
	sudo apt-get upgrade -y && \
    sudo apt-get install -y mariadb-server

COPY conf/mariadb.conf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/config_mariadb.sh /usr/local/bin/config_mariadb.sh
RUN chmod +x /usr/local/bin/config_mariadb.sh

ENTRYPOINT ["config_mariadb.sh"]

CMD ["mysqld"]