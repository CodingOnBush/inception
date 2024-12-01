#!/bin/bash

service mariadb start

# timeout=30
# while [ ! -e /run/mysqld/mysqld.sock ]; do
#     if [ $timeout -eq 0 ]; then
#         echo "Failed to run MariaDB"
#         exit 1
#     fi
#     timeout=$(($timeout - 1))
#     sleep 1
# done
sleep 10

if [ ! -e /run/mysqld/mysqld.pid ]; then
    echo "Failed to run MariaDB"
    exit 1
fi

echo "DB_NAME: $DB_NAME, DB_USER: $DB_USER"

echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" > /tmp/database.sql
echo "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'localhost' IDENTIFIED BY '${DB_PASS}';" >> /tmp/database.sql
echo "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASS}';" >> /tmp/database.sql
echo "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASS}';" >> /tmp/database.sql
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASS}');" >> /tmp/database.sql
echo "FLUSH PRIVILEGES;" >> /tmp/database.sql

mysql < /tmp/database.sql
echo "Hey! I'm done"
rm -f /tmp/database.sql

sleep 5
service mariadb stop

mysqld
