# Custom SQL Queries

The Custom SQL Queries feature of DBConvert Streams empowers users with granular control over data retrieval from the source database tables.

## Key Points

- Flexibility and Control: Users can specify custom SQL queries for individual tables in the filter section, tailoring data retrieval to their specific requirements.
- Conditions, Ordering, and Limiting: Customize queries for each table by incorporating conditions, ordering, limiting, and more.
- Enhanced Configuration: The filter section in the configuration now includes a `query` parameter for each table definition.

## Steps to Use

### 1. Start Services

```bash
docker compose up --build -d
```

This command will build and start the services listed in `docker-compose.yml` file.

Connect to the MySQL Container
```bash
mysql -h 127.0.0.1 -uroot -p
```

After connecting to the MySQL container, you will see the following:

```bash
MySQL [source]> show tables;
+------------------+
| Tables_in_source |
+------------------+
| attendance       |
| customers        |
| employees        |
| products         |
| sales            |
+------------------+
5 rows in set (0.003 sec)
```

So you will have 5 tables in MySQL populated with sample data.

### 2. Send Conversion Configuration to DBConvert Streams API

```bash
curl --request POST --url http://127.0.0.1:8020/api/v1/streams\?file=./config.json
```

### 3. Check the Data on the PostgreSQL Target Container
```bash
psql --host=0.0.0.0 --port=5432 --username=postgres --password --dbname=postgres
```

Now you will see the following:

```sql
psql (16.2, server 15.5)
Type "help" for help.

postgres=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | customers | table | postgres
 public | employees | table | postgres
 public | products  | table | postgres
 public | sales     | table | postgres
(4 rows)

postgres=# select count(*) from products; 
 count 
-------
     6
(1 row)

postgres=# select count(*) from customers; 
 count 
-------
     3
(1 row)
```
