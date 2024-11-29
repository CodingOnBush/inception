FROM	debian:bullseye

RUN apt-get update \
    && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 755 /var/run/mysqld
COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	./tools/db.sh /usr/local/bin/db.sh
RUN	chmod 755 /usr/local/bin/db.sh


EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/db.sh"]