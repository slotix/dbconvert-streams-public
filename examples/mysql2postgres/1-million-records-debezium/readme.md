The "io.debezium.connector.mysql.MySql" Connector from Debezium will be utilized for capturing changes in data from a MySQL database. The target for the captured data will be a Postgres database, with the "io.confluent.connect.jdbc.JdbcSinkConnector" connector class serving as the sink connector for the Postgres database.

## Table structure.

```bash
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

Source and Target Databases.
`mysql-source` database image is based on slotix/dbs-mysql:8, which has all the necessary settings to enable MySQL CDC replication. This image also contains the initdb.sql script, which creates table with the above structure.

We will populate the 'products' source table with data from the 'products.csv' file, which contains 1 million rows and takes about 300MB. It is generally not recommended to store large CSV files in a GitHub repository, so the 'products.csv' file is stored in cloud storage. We will download it from the storage and place it inside the Docker container when building the Docker image for the 'mysql-source' service.

`postgres-target` database is based on the official postgres:15-alpine image. postgres-target database will receive all changes made to the mysql-source database.

Both of these databases are usually on different physical servers in a production environment. But in our example, we will run them on the same machine in different containers.
This is a MySQL script to:

## Start.

```bash
export DEBEZIUM_VERSION=2.0
docker-compose up --build -d
```

### Deployment

#### Deploy of source connector to debezium.

```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @source.json
```

#### Deploy of sink connector to debezium.

```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @target.json
```

#### List of connectors.

Visit http://localhost:8083/connectors/ to view a list of active and running connectors.

### Populate source table with sample data.

To execute the SQL script that populates the source table with sample data, you can run the following commands:

```
docker compose exec -it \
    mysql-source \
    mysql -u root -p123456 -D source
```

In MySQL prompt, execute the following command

```sql
SELECT CURTIME();
LOAD DATA INFILE '/var/lib/mysql-files/products.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT CURTIME();
```

The code consists of three SQL commands executed in order:

1. The first line `SELECT CURTIME();` retrieves the current time from the MySQL database server.
2. The next line `LOAD DATA INFILE '/var/lib/mysql-files/products.csv' INTO TABLE products` loads data from a CSV file located at `/var/lib/mysql-files/products.csv` into a table named `products` in the database.
3. The following lines `FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;` specify the options for the data to be loaded into the table, such as the field separator (`,`), the character that encloses the fields (`"`), the line separator (`\n`), and to ignore the first row of the CSV file.
4. The final line `SELECT CURTIME();` retrieves the current time again.

### Verify the Record Count in the PostgreSQL Target.

```bash
 docker compose  exec postgres-target bash -c 'psql -U $POSTGRES_USER $POSTGRES_DB -c "select count(*) from products"'
```

### Stop the demo

```
docker compose down --remove-orphans
```
