# This Dockerfile derives the image from the base postgres image
# with necessary permissions and custom config to enable postgres replication.
FROM slotix/dbs-postgres:15-alpine

# copy sql script to create database and populate it with data.
COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d


#ENTRYPOINT ["docker-entrypoint.sh"] 
