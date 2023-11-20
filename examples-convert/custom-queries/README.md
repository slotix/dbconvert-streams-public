# Custom SQL Queries

The Custom SQL Queries feature of DBConvert Streams empowers users with granular control over data retrieval from the source database tables.

## Key points

- Flexibility and Control: Users can specify custom SQL queries for individual tables in the filter section, tailoring data retrieval to their specific requirements.
- Conditions, Ordering, Limiting: Customize queries for each table, incorporating conditions, ordering, limiting, and more.
- Enhanced Configuration: The filter section in the configuration now includes a "query" parameter for each table definition.

## Configuration Example

```json
{
  "source": {
    "type": "mysql",
    "mode": "convert",
    "connection": "root:123456@tcp(0.0.0.0:3306)/source",
    "dataBundleSize": 100,
    "reportingInterval": 5,
    "filter": {
      "tables": [
        {
          "name": "products",
          "query": "SELECT * FROM products LIMIT 3000000 OFFSET 100000"
        },
        {
          "name": "another_table",
          "query": "SELECT * FROM another_table WHERE storage > 10 LIMIT 3042"
        }
      ]
    }
  },
  "target": {
    "type": "postgresql",
    "connection": "postgres://postgres:postgres@0.0.0.0:5432/postgres",
    "reportingInterval": 5
  }
}
```
