# Examples

Most users configure streams through the DBConvert Streams UI — connections, table selection, and stream settings are all point-and-click. These examples are for the cases where the UI isn't enough:

- **`api/`** — standalone `stream-config.json` files for users driving DBConvert Streams via the REST API (CI/CD, scripted deployments, integration tests).
- **`benchmarks/`** — reproducible performance tests, including a side-by-side comparison against Debezium.

> **Note:** These examples are illustrative and may lag behind the current API. The **source of truth** for endpoints, request/response shapes, and field names is the live API documentation at **[streams.dbconvert.com/docs](https://streams.dbconvert.com/docs/)** (generated from the backend's OpenAPI/Swagger spec). If anything here disagrees with the docs, trust the docs.

## Using the API examples

Each file in `api/` is a complete stream-config payload. Connections are referenced by ID, so you create them once (via UI or API) and reuse them across configs.

### 1. Create connections

```bash
curl -X POST http://localhost:8020/api/v1/connections \
  -H "Content-Type: application/json" \
  -d '{
    "name": "mysql-source",
    "type": "mysql",
    "host": "localhost",
    "port": 3306,
    "username": "root",
    "password": "password"
  }'
```

The response includes an `id` — use it as `MYSQL_CONN_ID` below.

### 2. Submit a stream config

```bash
export MYSQL_CONN_ID=...
export PG_CONN_ID=...

envsubst < api/01-mysql-to-postgres-load.json | \
  curl -X POST http://localhost:8020/api/v1/stream-configs \
    -H "Content-Type: application/json" \
    -d @-
```

### 3. Start and monitor

```bash
curl -X POST http://localhost:8020/api/v1/stream-configs/<config-id>/start
curl http://localhost:8020/api/v1/streams/<stream-id>/stats
```

See the full [API documentation](https://streams.dbconvert.com/docs/) for all endpoints.

## Available examples

| File | Mode | Description |
|------|------|-------------|
| `api/01-mysql-to-postgres-load.json` | load | One-time MySQL → PostgreSQL migration with table selection |
| `api/02-mysql-to-postgres-cdc.json` | cdc | Real-time MySQL → PostgreSQL replication (insert/update/delete) |
| `api/03-postgres-to-s3-parquet.json` | load | Export PostgreSQL tables to Parquet on S3 |
| `api/04-federated-multi-source.json` | load | Join data from MySQL and PostgreSQL into a single target |

## Benchmarks

- **`benchmarks/bulk-migration-10m/`** — 10 million-row MySQL → PostgreSQL migration. Backs the throughput numbers in the main README.
- **`benchmarks/mysql-parquet-complex/`** — 5 million-row MySQL → Parquet export with native JSON columns (nested objects, arrays, nullable fields). Measures serialisation overhead vs scalar types.
- **`benchmarks/cdc-vs-debezium/`** — Side-by-side CDC throughput comparison against a Debezium + Kafka Connect pipeline. Includes Prometheus + JMX exporter for metrics.
