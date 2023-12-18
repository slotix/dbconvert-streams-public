
<p align="center">
  <img src="assets/images/dbconvert-stream-logo.svg" width="300" alt="DBConvert Streams Logo">
</p>

# DBConvert Streams: Database Conversion and Real-time Replication

Welcome to DBConvert Streams! This repository provides examples, configuration files, and Docker files for utilizing DBConvert Streams in various scenarios. If you have any questions or comments, feel free to open an issue.

## What is DBConvert Streams?

[DBConvert Streams (DBS)](https://stream.dbconvert.com/guide/introduction) is a cutting-edge distributed platform designed for heterogeneous database conversion and real-time data replication. It simplifies the process of transferring data between on-premises or cloud databases, including relational databases and data warehouses. DBConvert Streams operates in two modes:

### Modes of Data Transfer:

1. **Conversion Mode:**
   Quickly transfer data between on-premises or cloud databases, whether they are relational or data warehouses.

2. **CDC (Change Data Capture) Mode:**
   Stream changes from the source to the target database using [change data capture](https://dbconvert.com/blog/change-data-capture-cdc-what-it-is-and-how-it-works/) technology. DBConvert Streams keeps track of the source database, capturing all `Insert,` `Update,` and `Delete` row-level changes, allowing your applications to respond to events with minimal latency.


## Blazing Speed

DBConvert Streams is engineered for speed! In the latest performance tests, migrating 50 million records—totaling approximately 150 GB of data—from MySQL to Postgres was completed in a staggering 21 minutes and 10 seconds. Experience unprecedented efficiency in your database migration and replication processes.

![test results](https://github.com/slotix/dbconvert-streams-public/blob/main/assets/images/50M-Recs.png)


## Supported Databases:

DBConvert Streams currently supports the following databases:

- MySQL
- MariaDB
- Percona
- PostgreSQL
- CockroachDB
- Amazon RDS for MySQL
- Amazon Aurora (MySQL Compatible)
- Amazon RDS for PostgreSQL
- Amazon Aurora (PostgreSQL Compatible)

## Supported Platforms:

The native DBConvert Binaries are available for the following operating systems:

- Linux AMD 64
- Linux ARM 64
- Apple macOS
- Windows
- Docker images

## Getting Started:

### Download DBConvert Streams:

Links to the latest binaries are available at [DBConvert Streams releases](https://stream.dbconvert.com/dbs-releases).

Alternatively, you can start DBConvert Streams via [Docker images](https://github.com/slotix/dbconvert-streams-public/blob/main/docker-images/docker-compose.yml).

### Deployment:

DBConvert Streams can be deployed on the following cloud platforms:

- [Amazon Web Services (AWS)](https://stream.dbconvert.com/guide/deploy-ec2)
- Google Cloud
- Microsoft Azure

Feel the power of seamless database conversion and real-time replication with DBConvert Streams!
