FROM	debian:bullseye

EXPOSE 3306

RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y \
    mariadb-server &&\
    rm -rf /var/lib/apt/lists/*

#config file for mariadb specifically
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

#setup mariadb via script
COPY ./tools/db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/db.sh

CMD [ "db.sh", "mysqld" ]