# Stream 1 Million records from MySQL to PostgreSQL.

This example shows how to set up DBConvert Streams for streaming 1 million records from a MySQL Binlog using Change Data Capture (CDC) to a PostgreSQL database.
Let's take a look at the `docker-compose.yml` file.

## DBConvert Streams services.

- `dbs-api` service is the entry point of DBConvert Streams. We will send requests there with configuration settings for the source and target databases.
- `dbs-source-reader` service monitors data changes in the source database and sends batches of records to the Event Hub.
- `dbs-target-writer` service receives changes from the Event Hub and upload them to the target database.
- `nats` service is the core of the Event Hub. It provides communication between other DBS services.
- `prometheus` - service for monitoring DBS services metrics.

## Database services.

### Table structure.

```bash
mysql> describe products;
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

### Source and Target Databases.

`mysql-source` database image is based on `slotix/dbs-mysql:8`, which has all the necessary settings to enable MySQL CDC replication. This image also contains the `initdb.sql` script, which creates table with the above structure.   
We will populate the 'products' source table with random data generated by the script below.

`postgres-target` database is based on the official `postgres:15-alpine` image. `postgres-target` database will receive all changes made to the `mysql-source` database.

These databases are usually on different physical servers in a production environment. But in our example, we will run them on the same machine in different containers.

## Execution.

### Step 1. Start services.

```bash
docker-compose up  --build -d
```

The command above will build and start the services listed in `docker-compose.yml` file in the background.

Note that the command needs to be run in the same directory where the `docker-compose.yml` file is located.

### Step 2. Send stream configuration.

Send a request to the DBConvert Streams API with configuration parameters.  
You can either send the request using `curl` in a containerized environment or `curl` installed locally.

To send the request using containerized `curl`, run the following command:

```bash
docker run -it --rm \
    --network 1-million-records_default \
    curlimages/curl  \
    --request POST \
    --url http://dbs-api:8020/api/v1/streams\?file=./mysql2pg.json
```

To send the request using curl installed locally, you can run the `curl` command without the `docker run` command.

```bash
curl --request POST --url http://127.0.0.1:8020/api/v1/streams\?file=./mysql2pg.json
```

### Step 3. Populate the source table with sample data.

To execute the SQL script that populates the source table with sample data, you can run the following commands:

```bash
docker exec -it \
    mysql-source \
    mysql -uroot -p123456 -D source
```

In MySQL prompt, execute the following command

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
    (SELECT @row := 0) r
  ) numbers
LIMIT 1000000;
```

### Step 4. Control the process. 
>This step is obsolete now and can be omitted. DBConvert Streams is able to report its progress by itself when the `reportingInterval` is set to something other than 0 (in seconds). It allows users to define the frequency at which progress reports are generated to keep users informed about the status of data transfer.

~~In the next terminal run the following command to control the process.~~

```bash
watch -n 1 'curl --request GET --url http://0.0.0.0:8020/api/v1/streams/stat | jq'
```
~~This command monitors the status of an API stream by repeatedly fetching and parsing the data every second from the stream using the `curl` and `jq` tools.~~

```sql
docker exec -it postgres-target psql -U postgres -d postgres -c "SELECT COUNT(*) FROM products;"
```

### Stop the demo
```
docker compose down --remove-orphans
```