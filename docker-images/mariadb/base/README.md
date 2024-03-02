## MariaDB Base Docker Image with Binlog Replication

To enable Change Data Capture (CDC) in MariaDB, the server must be configured for binlog replication.

```ini
[mariadb]

# ----------------------------------------------
# Enable the binlog for replication & CDC
# ----------------------------------------------
#
log-bin
server_id=1
log-basename=master1
binlog-format=mixed
binlog_row_event_max_size=16384

bind-address = 0.0.0.0
```

This image is based on the [official MariaDB image](https://hub.docker.com/_/mariadb). It configures the original MariaDB Docker image to enable MariaDB binlog replication.

## What is DBConvert Streams?

[DBConvert Streams (DBS)](https://stream.dbconvert.com/sources/what-is-cdc) is a distributed platform for change data capture. It tracks changes in a source database, capturing all `INSERT`, `UPDATE`, and `DELETE` row-level changes. This enables your applications to respond to these captured events with very low latency.

