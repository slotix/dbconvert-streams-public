# MySQL base docker image with Binlog Replication.

To make Change Data Capture (CDC) available, MySQL server must be configured to enable binlog replication.

```
[mysqld]
server_id        =  181818
log_bin          =  mysql-bin
binlog_format    =  row
binlog_row_image =  full
```

This image is based on official [MySQL:8](https://hub.docker.com/_/mysql).  
It configures original MySQL docker image to enable MySQL Binlog replication.

This is a minimal configuration docker image for DBConvert Streams.

## What is DBConvert Streams?

[DBConvert Streams (DBS)](https://stream.dbconvert.com/guide/introduction) is a distributed platform for change data capture. It keeps track a source database and captures all `Insert`, `Update` and `Delete` row-level changes. This allows your applications to respond to those captured events with very low latency.
