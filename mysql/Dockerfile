FROM mysql:5.7.21

COPY conf.d/* /etc/mysql/conf.d/

# This will/should import sql at startup!
COPY ./import.sql /docker-entrypoint-initdb.d/import.sql