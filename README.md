# DBConvert Streams Docker images, Examples.

This repository contains several examples of using DBConvert Streams, e.g. configuration files, Docker files.

## What is DBConvert Streams?
[DBConvert Streams (DBS)](https://stream.dbconvert.com/guide/introduction) is a distributed platform for heterogeneous database conversion and real-time data replication. 

There are two modes for data transfer between source and target databases:
1. **Conversion Mode.** This Mode helps quickly transfer data between on-prem or cloud databases, relational or data warehouses.
2. **CDC (change data capture) Mode** Stream changes from the source to the target database using [change data capture](https://dbconvert.com/blog/change-data-capture-cdc-what-it-is-and-how-it-works/) technology. DBConvert Streams keeps track of a source database and captures all `Insert,` `Update,` and `Delete` row-level changes. This way, your applications respond to those captured events with very low latency.

## DBConvert Streams currently supports the following databases:

- MySQL
- MariaDB
- Percona
- PostgreSQL
- CockroachDB
- Amazon RDS for MySQL
- Amazon Aurora (MySQL Compatible)
- Amazon RDS for PostgreSQL
- Amazon Aurora (PostgreSQL Compatible)


## Supported platforms.
The native DBConvert Binaries are available for the following operating systems.

- Linux AMD 64
- Linux ARM 64
- Apple OS X
- Windows
- Docker images

## Deployment.
DBConvert Streams can be deployed on the following cloud platforms:

[Amazon Web Services (AWS)](https://stream.dbconvert.com/guide/deploy-ec2)
Google Cloud
Microsoft Azure
