# PostgreSQL to MySQL conversion example.

This example demonstrates how to set up DBConvert Streams for converting data from a PostgreSQL database to a MySQL database.  
Let's examine the `docker-compose.yml` file.

## DBConvert Streams services.

- `dbs-api` service is the entry point of DBConvert Streams. We will send requests to api service with configuration settings for the source and target databases.
- `dbs-source-reader` service reads table data from the source database and sends batches of records to the Event Hub.
- `dbs-target-writer` service instances subscribe to new records in the Event Hub. Once these records appear, the instances start consuming them and sending them to the target database.
- `nats` service is the core of the Event Hub. It provides communication between other DBS services.
- `prometheus` - service for monitoring DBS services metrics.

## Database services.

We use SQL scripts from [jdaarevalo/docker_postgres_with_data](https://github.com/jdaarevalo/docker_postgres_with_data) GitHub repository to create new table structures in the source database and populate those tables with data.

### Entity Relationship (ER) Diagram of Database.

The structure of tables is shown on the diagram below.
![ER Diagram of DB](../../img/sales-db-erd.png)



### Source and Target Databases.

`postgres-source` database image is based on official `postgres:15-alpine`, which contains the `initdb.sql` script that creates tables with the above structures.

The `mysql-target` database is the target database used to migrate data from `postgres-source`. It is based on the official `mysql:8.0` docker image. Initially, it doesn't contain any tables. Instead, tables identical to those in `postgres-source` are created automatically before migrating data.

Both of these databases are usually on different physical servers in a production environment. But in our example, we will run them on the same machine in different containers.


## Execution.

### Step 1. Start services.

```bash
docker-compose up  --build -d
```

The docker-compose up command is used to start and run all the services defined in the 'docker-compose.yml' file.

The command above will start the services in the background, build the images and use the docker-compose.yml file to configure the services.

Note that the command needs to be ran in the same directory where the `docker-compose.yml` file is located.


### Step 2. Populate source tables with sample data.

The Variables at the top of `fill_tables.sql` file are used to specify the number of rows to create in the corresponding table.

To execute the SQL script that populates the source tables with sample data, you can run the following command:

```bash
docker run -it --rm  \
    -e PGPASSWORD=postgres \
    --network sales-db_default \
    -v "$PWD/fill_tables.sql":/docker-entrypoint-initdb.d/fill_tables.sql \
    postgres:15-alpine \
    psql -h postgres-source -U postgres -d postgres -a -f /docker-entrypoint-initdb.d/fill_tables.sql
```

### Step 3. Send stream configuration.

Send a request to the DBConvert Streams API with configuration parameters.  

```
curl --request POST --url http://127.0.0.1:8020/api/v1/streams\?file=./pg2mysql.json    
```


### Step 4. Control the process. 
In the next terminal run the following command to control the process.  
```bash
watch -n 1 'curl --request GET --url http://0.0.0.0:8020/api/v1/streams/stat | jq' 
```
This command monitors the status of an API stream by repeatedly fetching and parsing the data every second from the stream using the `curl` and `jq` tools.


### Stop the demo
```
docker compose down 
```
