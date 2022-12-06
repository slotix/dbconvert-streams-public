# This Dockerfile contains the image specification of our database
FROM postgres:15-alpine

COPY ./postgresql.conf.sample /usr/local/share/postgresql/postgresql.conf.sample

# Copy the script which will initialize the replication permissions
# COPY ./docker-entrypoint-initdb.d/init-permissions.sh /docker-entrypoint-initdb.d
COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d


ENTRYPOINT ["docker-entrypoint.sh"] 
