# This Dockerfile derives the image from the official postgres alpine image
# with necessary permissions and custom config to enable postgres replication.
FROM postgres:15-alpine
COPY ./postgresql.conf.sample /usr/local/share/postgresql/postgresql.conf.sample

# Copy the script to configure the replication permissions.
COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
# RUN chown postgres:postgres /docker-entrypoint-initdb.d/init-permissions.sh

ENTRYPOINT ["docker-entrypoint.sh"] 
