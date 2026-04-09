<p align="center">
  <img src="assets/images/dbconvert-stream-logo.svg" width="300" alt="DBConvert Streams Logo">
</p>

# DBConvert Streams 2.0: Database IDE, Federated SQL & Real-time CDC

Explore, query, and replicate data — all in one tool. A database IDE with federated SQL across databases and files, combined with high-performance data migration and real-time Change Data Capture (CDC).

> **Note:** This is a public repository for example configurations, documentation, and issue tracking. The core backend code of DBConvert Streams is proprietary, while the frontend UI is open source and available at [github.com/slotix/dbconvert-streams-ui](https://github.com/slotix/dbconvert-streams-ui).

## Quick Start

### Desktop App

[Download](https://streams.dbconvert.com/download) for Windows, macOS, or Linux — no account required.

### Self-Hosted (Docker)

Deploy for team access via browser:

```bash
curl -fsSL https://dbconvert.nyc3.digitaloceanspaces.com/downloads/streams/latest/docker-install.sh | sh
```

## What is DBConvert Streams?

[DBConvert Streams](https://streams.dbconvert.com) is a database IDE and data streaming platform. It combines a free database workspace with powerful data migration and real-time CDC replication between databases and file-based sources.

Browse databases, local files, and S3 storage. Edit data directly. Run federated SQL queries that join tables across different database engines — all without intermediate exports.

## Key Features

### Database IDE & Workspace (Free)
- **Data Explorer** — Browse schemas, edit data inline with staged changes and review
- **ER Diagrams** — Visualize database relationships
- **Schema Comparison** — Compare schemas and data across databases
- **Schema Navigation** — Persistent state and search across connections

### Federated SQL
- Execute SQL queries across multiple databases and file sources simultaneously
- Join live PostgreSQL and MySQL tables using connection aliases
- Query CSV, JSON, Parquet files and S3 storage alongside databases

### Data Migration (Convert Mode)
Rapidly move large datasets between databases with automatic schema conversion and validation.

> **Performance:** 23 million rows (4.38 GB) migrated from MySQL to Parquet in 35.7 seconds at 136 MB/s.

### Real-time CDC (Change Data Capture)
Stream `INSERT`, `UPDATE`, and `DELETE` operations from source to target in real-time with minimal latency. Supports CDC to databases, files, and S3 storage.

## Screenshots

### Data Explorer
Browse schemas, view and edit data across multiple database connections with a unified tree navigation:

![DBConvert Streams Data Explorer](assets/images/sshot-data-explorer.webp)

### Federated SQL
Join tables across MySQL, PostgreSQL, and file sources (CSV, Parquet) in a single query:

![DBConvert Streams Federated SQL](assets/images/sshot-federated-sql.webp)

### ER Diagrams
Visualize database relationships with interactive entity-relationship diagrams:

![DBConvert Streams ER Diagram](assets/images/sshot-er-diagram.webp)

### Stream Configuration
Configure data migration and CDC streams with table selection, custom queries, and transfer settings:

![DBConvert Streams Configuration](assets/images/sshot-configure-stream.webp)

### Stream Monitoring
Track data streams with real-time metrics — rows, data size, transfer rates, and per-table progress:

![DBConvert Streams Monitor](assets/images/sshot-stream-monitor.webp)

## Supported Sources & Targets

### Databases
- MySQL / MariaDB / Percona
- PostgreSQL / CockroachDB
- Amazon RDS (MySQL, PostgreSQL)
- Amazon Aurora (MySQL, PostgreSQL Compatible)
- Google Cloud SQL
- Azure Database

### File Formats & Storage
- Parquet
- CSV
- JSON / JSONL
- S3-compatible storage

## Deployment Options

| Method | Description |
|--------|-------------|
| **Desktop** | Windows, macOS, Linux — local setup, no account required |
| **Self-hosted** | Docker / Docker Compose — team access via browser |

## Pricing

The Database IDE is **free forever**. For data migration and CDC streaming, see [pricing details](https://streams.dbconvert.com/pricing).

## Examples

This repository includes ready-to-use Docker Compose examples:

### Convert (Data Migration)
- [PostgreSQL → MySQL](examples-convert/postgres2mysql/) — Sales database migration
- [MySQL → PostgreSQL](examples-convert/mysql2postgres/) — 10 million records benchmark
- [Custom SQL Queries](examples-convert/custom-queries/) — Selective migration with WHERE filters

### CDC (Change Data Capture)
- [MySQL → MySQL](examples-cdc/mysql/) — Same-engine CDC replication
- [PostgreSQL → PostgreSQL](examples-cdc/postgresql/) — PostgreSQL logical decoding
- [MySQL → PostgreSQL](examples-cdc/mysql2postgres/) — Cross-database CDC (includes 1M records, AWS, CSV, and Debezium variants)
- [PostgreSQL → MySQL](examples-cdc/postgres2mysql/) — Reverse direction CDC

## Learn More

- [Documentation](https://streams.dbconvert.com/docs/)
- [What's New in 2.0](https://streams.dbconvert.com/blog/dbconvert-streams-2-0/)

## Feedback and Support

Have questions or feedback? Use [Discussions](https://github.com/slotix/dbconvert-streams-public/discussions) or open an [Issue](https://github.com/slotix/dbconvert-streams-public/issues).
