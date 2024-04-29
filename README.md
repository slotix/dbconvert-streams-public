
<p align="center">
  <img src="assets/images/dbconvert-stream-logo.svg" width="300" alt="DBConvert Streams Logo">
</p>

# DBConvert Streams: Database Conversion and Real-time Replication

This repository provides examples, configuration files, and Docker files for utilizing DBConvert Streams in various scenarios. If you have any questions or comments, feel free to open an issue.

## What is DBConvert Streams?

[DBConvert Streams (DBS)](https://stream.dbconvert.com/guide/introduction) is a cutting-edge distributed platform designed for data migration between heterogeneous databases and real-time data replication. It simplifies the process of transferring data between on-premises or cloud databases, including relational databases and data warehouses. DBConvert Streams operates in two modes:

### Modes of Data Transfer:

1. **Dat migration (Conversion) Mode:**
   Quickly transfer data between on-premises or cloud databases, whether they are relational or data warehouses.

2. **CDC (Change Data Capture) Mode:**
   Stream changes from the source to the target database using [change data capture](https://dbconvert.com/blog/change-data-capture-cdc-what-it-is-and-how-it-works/) technology. DBConvert Streams keeps track of the source database, capturing all `Insert,` `Update,` and `Delete` row-level changes, allowing your applications to respond to events with minimal latency.


### Workflow.

1. **Reader Component**: Retrieves the meta-structure of tables and indexes from the source database.

2. **Forwarding to NATS**: The retrieved meta structures are forwarded to Event Hub (NATS), serving as a messaging system for communication between components.

3. **Target Writer Selection**: Among the available target writers, a specific one is chosen to handle the execution of `CREATE TABLE`, `CREATE INDEX` DDL statements on the target Database.

4. **DDL Translation and Structure Creation**: The chosen target writer translates DDLs and attempts to create the corresponding structure on the target database. During this phase, other target writers remain inactive until the structure creation process is completed.

5. **Notification and Data Reception**: Once the `CREATE TABLE`, `CREATE INDEX` DDLs are successfully executed, indicating the creation of table structures on the target database, the chosen target writer notifies other target writers to proceed with receiving data.

6. **Data Transfer**: Data transfer involves fetching data from the source database in batches to optimize performance and reduce resource consumption. Batch size is configurable based on factors such as network latency, database load, and system resources.

7. **Logging and Monitoring**: Throughout the data transfer process, comprehensive logging and monitoring mechanisms track progress, identify errors or anomalies, and ensure timely resolution.

8. **Completion Notification**: Once all data is successfully transferred to the target database, target writers send a completion notification, indicating the end of the data transfer process.


## Blazing Speed

> DBConvert Streams, the speedster of database migration tools, raced through the latest performance tests with finesse. Picture this: 50 million records, around 150 GB of data, zooming from MySQL to Postgres in just over 20 minutes. And here's the cherry on top—speeds reaching up to 120 Mb per second. Brace yourself for unparalleled efficiency in your database migration and replication processes!

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


## 📢 Calling all DBConvert Streams users! 📢

Your feedback matters! We want to hear from you about your experience with DBConvert Streams. Please take a moment to participate in our User Feedback Poll. Your insights will help us improve our product to better meet your needs.

[👉 Click here to participate in the poll 👈](https://github.com/slotix/dbconvert-streams-public/discussions/33)

Thank you for your time and valuable input! Your feedback is crucial in shaping the future of DBConvert Streams.


Feel the power of seamless database conversion and real-time replication with DBConvert Streams!
