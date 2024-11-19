# Utiliser une image de base Debian
FROM debian:bullseye

# Installer MariaDB
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init_db.sh /usr/local/bin/init_db.sh
RUN chmod +x /usr/local/bin/init_db.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init_db.sh"]