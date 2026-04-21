# MySQL to PostgreSQL: 10 Million Records

Load 10 million records from a MySQL `products` table into PostgreSQL.

## Prerequisites

- **DBConvert Streams** running (via [desktop app](https://dbconvert.com) or [docker-install.sh](https://github.com/slotix/dbconvert-streams-public))
- **Docker** and **Docker Compose** for test databases
- **curl** and **jq** installed

## Table Structure

```
+---------+---------------+------+-----+-------------------+-------------------+
| Field   | Type          | Null | Key | Default           | Extra             |
+---------+---------------+------+-----+-------------------+-------------------+
| id      | bigint        | NO   | PRI | NULL              |                   |
| name    | varchar(255)  | NO   |     | NULL              |                   |
| price   | decimal(10,2) | NO   |     | NULL              |                   |
| weight  | double        | YES  |     | NULL              |                   |
| created | timestamp     | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+---------+---------------+------+-----+-------------------+-------------------+
```

## Steps

### 1. Start test databases

```bash
docker compose up --build -d
```

### 2. Populate the source table with 10M records

```bash
docker exec -it mysql-source mysql -uroot -p123456 -D source
```

In the MySQL prompt, run:

```sql
INSERT INTO products (name, price, weight)
SELECT
  CONCAT('Product', number) AS name,
  ROUND(RAND() * 100, 2) AS price,
  RAND() * 10 AS weight
FROM
  (SELECT @row := @row + 1 AS number FROM
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
     UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
     UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t2,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
     UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t3,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
     UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t4,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
     UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t5,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
     UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t6,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
     UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t7,
    (SELECT @row := 0) r
  ) numbers
LIMIT 10000000;
```

### 3. Run setup script

```bash
./setup.sh
```

This creates the connections, configures the stream, and starts the load.

### 4. Monitor progress and verify

Stats from the stream API are the source of truth — they report rows read from the source and rows written to the target, per table, in real time.

```bash
# Live monitor (updates every second)
watch -n 1 'curl -s http://localhost:8020/api/v1/streams/stat | jq'

# Final per-table counts when the stream completes
curl -s http://localhost:8020/api/v1/streams/<stream-id>/stats | jq
```

The `setup.sh` script prints the `<stream-id>` after starting the stream. Look for `rowsWritten` per table to confirm all 10M rows landed in the target.

### Stop the demo

```bash
docker compose down --remove-orphans
```

## Documentation

- [DBConvert Streams Docs](https://stream.dbconvert.com)
