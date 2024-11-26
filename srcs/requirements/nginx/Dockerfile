FROM	debian:bullseye

EXPOSE	443

RUN		apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
		nginx \
		openssl && \
		rm -rf /var/lib/apt/lists/*

RUN		mkdir -p ${CERT_FOLDER} && \
		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
		-out ${CERTIFICATE} \
		-keyout ${KEY} \
		-subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${COMMON_NAME}"

COPY	conf/nginx.conf	/etc/nginx/
COPY	conf/server.conf	/etc/nginx/conf.d/

RUN		echo "\tserver_name ${COMMON_NAME};\n\
		\tssl_certificate ${CERTIFICATE};\n\
		\tssl_certificate_key ${KEY};\n\
		}" >> /etc/nginx/conf.d/server.conf

RUN		mkdir -p /var/www/
RUN		chown -R www-data:www-data /var/www/

CMD		["nginx", "-g", "daemon off;"]