# Stream 1 Million of records from MySQL to PostgreSQL.

This example shows how to set up DBConvert Streams for streaming 1 million records from a MySQL Binlog using Change Data Capture (CDC) to a PostgreSQL database.
Let's take a look at the `docker-compose.yml` file.

## DBConvert Streams services.

- `dbs-api` service is the entry point of DBConvert Streams. We will send requests there with configuration settings for the source and target databases.
- `dbs-source-reader` service monitors data changes in the source database and sends batches of records to the Event Hub.
- `dbs-target-writer` service is used to receive changes from the Event Hub and upload them to the target database.
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

`mysql-source` database image is based on `slotix/dbs-mysql:8`, which has all the necessary settings to enable MySQL CDC replication. This image also contains the `initdb.sql` script, which creates table  with the above structure.   
We will populate the 'products' source table with data from the 'products.csv' file, which contains 1 million rows and takes about 300MB. It is generally not recommended to store large CSV files in a GitHub repository, so the 'products.csv' file is stored in cloud storage. We will download it from the storage and place it inside the Docker container when building the Docker image for the 'mysql-source' service.
 
`postgres-target` database is based on the official `postgres:15-alpine` image. `postgres-target` database will receive all changes made to the `mysql-source` database.

Both of these databases are usually on different physical servers in a production environment. But in our example, we will run them on the same machine in different containers.

## Execution.

### Step 1. Start services.

```bash
docker-compose up  --build -d
```

The docker-compose up command is used to start and run all the services defined in the 'docker-compose.yml' file.

The command above will start the services in the background, build the images and use the docker-compose.yml file to configure the services.

Note that the command needs to be ran in the same directory where the docker-compose.yml file is located.

### Step 2. Send stream configuration.

Send a request to the DBConvert Streams API with configuration parameters.  
You can either send the request using `curl` in a containerized environment or using `curl` installed locally.

To send the request using containerized `curl`, run the following command:

```bash
docker run -it --rm \
    --network 1-million-records_default \
    curlimages/curl  \
    --request POST \
    --url http://dbs-api:8020/api/v1/streams\?file=./mysql2pg.json
```

To send the request using curl installed locally, you can simply run the `curl` command without the `docker run` command.

```
curl --request POST --url http://127.0.0.1:8020/api/v1/streams\?file=./mysql2pg.json
```

### Step 3. Populate source table with sample data.

To execute the SQL script that populates the source table with sample data, you can run the following commands:

```
docker exec -it \
    mysql-source \
    mysql -uroot -p123456 -D source
```

In MySQL prompt, execute the following command

```sql
LOAD DATA INFILE '/var/lib/mysql-files/products.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

1. The line `LOAD DATA INFILE '/var/lib/mysql-files/products.csv' INTO TABLE products` loads data from a CSV file located at `/var/lib/mysql-files/products.csv` into a table named `products` in the database.
2. The following lines `FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;` specify the options for the data to be loaded into the table, such as the field separator (`,`), the character that encloses the fields (`"`), the line separator (`\n`), and to ignore the first row of the CSV file.
