FROM	debian:bullseye

RUN		env

EXPOSE	3306

RUN		apt-get update && \
		apt-get install -y --no-install-recommends --no-install-suggests \
		mariadb-server && \
		rm -rf /var/lib/apt/lists/*

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY	tools/setup_db.sh /bin/
RUN		chmod +x /bin/setup_db.sh

CMD		["setup_db.sh", "mysqld_safe"]