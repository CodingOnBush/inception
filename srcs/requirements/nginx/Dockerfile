FROM	debian:bullseye

RUN		apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
		nginx

COPY	./conf/nginx.conf /etc/nginx

RUN 	chown -R www-data:www-data /var/www/html

# RUN		env

# EXPOSE	443

# RUN		apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
# 		nginx \
# 		openssl && \
# 		rm -rf /var/lib/apt/lists/*

# ARG		CERT_FOLDER
# ARG		CERTIFICATE
# ARG		KEY
# ARG		COUNTRY
# ARG		STATE
# ARG		LOCALITY
# ARG		ORGANIZATION
# ARG		UNIT
# ARG		COMMON_NAME

# RUN		echo "CERT_FOLDER="${CERT_FOLDER}

# RUN		mkdir -p ${CERT_FOLDER}

# RUN		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
# 		-out ${CERTIFICATE} \
# 		-keyout ${KEY} \
# 		-subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${COMMON_NAME}"

# COPY	conf/nginx.conf /etc/nginx/nginx.conf

# # 		Create the folder for the wordpress files and change its owner to www-data user.
# RUN		mkdir -p /var/www/
# RUN		chown -R www-data:www-data /var/www/

CMD		["nginx", "-g", "daemon off;"]