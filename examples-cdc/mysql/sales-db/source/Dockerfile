# This Dockerfile derives the image from the base slotix/dbs-mysql image
# with necessary permissions and custom config to enable mysql replication.
FROM slotix/dbs-mysql:8

# copy sql script to create database and table structures.
COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
