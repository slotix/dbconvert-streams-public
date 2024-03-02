# This Dockerfile derives the image from the official mysql image.
# with custom config to enable mysql replication.
FROM mariadb:latest

# Copy custom config to enable mysql binlog replication.
COPY mysql.cnf /etc/mysql/conf.d/
