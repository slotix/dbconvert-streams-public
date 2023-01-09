# This Dockerfile derives the image from the official mysql image.
# with custom config to enable mysql replication.
FROM mysql:8.0

# Copy custom config to enable mysql binlog replication.
COPY mysql.cnf /etc/mysql/conf.d/
