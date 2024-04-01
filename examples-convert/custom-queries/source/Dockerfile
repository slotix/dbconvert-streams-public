# This Dockerfile derives the image from the base mysql image
FROM mysql:8.0
# copy sql script to create database and table structures.
COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

