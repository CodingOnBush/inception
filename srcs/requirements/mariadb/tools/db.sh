#!/bin/bash

# Start MariaDB service
service mariadb start

# Wait for the MariaDB socket to be available
timeout=30
while [ ! -e /run/mysqld/mysqld.sock ]; do
    timeout=$(($timeout - 1))
    if [ $timeout -eq 0 ]; then
        echo "[MARIADB] Failed to run MariaDB"
        exit 1
    fi
    sleep 1
done

# Wait for the MariaDB pid file to be available
if [ ! -e /run/mysqld/mysqld.pid ]; then
    echo "[MARIADB] Failed to run MariaDB"
    exit 1
fi

# Prepare the SQL commands in a temporary file (/tmp/database.sql)
echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" > /tmp/database.sql
echo "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'localhost' IDENTIFIED BY '${DB_PASS}';" >> /tmp/database.sql
echo "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASS}';" >> /tmp/database.sql
echo "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASS}';" >> /tmp/database.sql
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASS}');" >> /tmp/database.sql
echo "FLUSH PRIVILEGES;" >> /tmp/database.sql

# Execute the SQL commands
mysql < /tmp/database.sql

# Clean up
rm -f /tmp/database.sql

sleep 5

# Stop MariaDB service
service mariadb stop

# Restart MariaDB with the specified command
mysqld
