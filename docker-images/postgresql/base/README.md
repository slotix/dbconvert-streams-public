# PostgreSQL base image with CDC.

To make PostgreSQL Change Data Capture (CDC) available, [logical decoding](https://www.postgresql.org/docs/15/logicaldecoding-explanation.html) must be enabled.

Find an article in our blog explaining [CDC based on PostgreSQL logical decoding feature](https://dbconvert.com/blog/postgresql-change-data-capture-cdc/)

This image is based on [postgres:15-alpine](https://hub.docker.com/_/postgres/).  
It configures original PostgreSQL docker image to enable logical decoding and CDC replication.

```
# REPLICATION
wal_level=logical
max_replication_slots=5
max_wal_senders=10
wal_sender_timeout=0
```

This is a minimal configuration docker image for DBConvert Streams.

## What is DBConvert Streams?

[DBConvert Streams (DBS)](https://stream.dbconvert.com/guide/introduction) is a distributed platform for change data capture. It keeps track a source database and captures all `Insert`, `Update` and `Delete` row-level changes. This allows your applications to respond to those captured events with very low latency.
