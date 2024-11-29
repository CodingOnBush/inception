#!/bin/sh
if [ -d "/var/lib/mysql/${DB_NAME}" ]
then
	echo "${DB_NAME} already exists\n"
	#sleep 2
	#mysqladmin -u root -p${DB_ROOT_PASS} shutdown
	sleep 5
else
	service mariadb start
	sleep 5
	echo "creating ${DB_NAME}\n"
	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '$DB_PASS';"
	mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
	sleep 5

	mysqladmin -u root -p${DB_ROOT_PASS} shutdown
	sleep 5
fi
exec mysqld

# #!/bin/bash

#  # Start mysql service
#  service mysql start

#  sleep 20

#  # Create SQL file with database setup commands
#  echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > /tmp/db.sql

#  echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' ;" >> /tmp/db.sql

#  echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> /tmp/db.sql

#  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS' ;" >> /tmp/db.sql

#  echo "FLUSH PRIVILEGES;" >> /tmp/db.sql

# # Execute SQL file
# mysql -u root -p"$DB_ROOT_PASS" < /tmp/db.sql
# # mysql < /tmp/db.sql

# rm -f /tmp/db.sql

# # Stop mysql service            |  #  sends a signal to the MariaDB process to stop it
# service mysql stop			    |  #  kill $(cat /var/run/mysqld/mysqld.pid)

# # kill $(cat /var/run/mysqld/mysqld.pid)

# mysqld
# #  mysqld --bind-address=0.0.0.0