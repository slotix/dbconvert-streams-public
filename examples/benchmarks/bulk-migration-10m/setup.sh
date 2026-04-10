#!/usr/bin/env bash
set -euo pipefail

API_URL="http://localhost:8020/api/v1"

echo "Waiting for DBConvert Streams API to be ready..."
until curl -s "${API_URL}/connections" > /dev/null 2>&1; do
  sleep 2
done
echo "API is ready."

# Create source MySQL connection
echo "Creating source MySQL connection..."
MYSQL_RESPONSE=$(curl -s -X POST "${API_URL}/connections" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "mysql-source",
    "type": "mysql",
    "host": "localhost",
    "port": 3306,
    "username": "root",
    "password": "123456"
  }')

MYSQL_CONN_ID=$(echo "$MYSQL_RESPONSE" | jq -r '.id')
if [ "$MYSQL_CONN_ID" = "null" ] || [ -z "$MYSQL_CONN_ID" ]; then
  echo "Error creating source connection: $MYSQL_RESPONSE"
  exit 1
fi
echo "Source connection created: $MYSQL_CONN_ID"

# Create target PostgreSQL connection
echo "Creating target PostgreSQL connection..."
PG_RESPONSE=$(curl -s -X POST "${API_URL}/connections" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "postgres-target",
    "type": "postgresql",
    "host": "localhost",
    "port": 5432,
    "username": "postgres",
    "password": "postgres"
  }')

PG_CONN_ID=$(echo "$PG_RESPONSE" | jq -r '.id')
if [ "$PG_CONN_ID" = "null" ] || [ -z "$PG_CONN_ID" ]; then
  echo "Error creating target connection: $PG_RESPONSE"
  exit 1
fi
echo "Target connection created: $PG_CONN_ID"

# Build stream config with actual connection IDs
STREAM_CONFIG=$(cat stream-config.json \
  | sed "s/\${MYSQL_CONN_ID}/$MYSQL_CONN_ID/g" \
  | sed "s/\${PG_CONN_ID}/$PG_CONN_ID/g")

# Create and start the stream
echo "Creating stream..."
STREAM_RESPONSE=$(curl -s -X POST "${API_URL}/streams" \
  -H "Content-Type: application/json" \
  -d "$STREAM_CONFIG")

STREAM_ID=$(echo "$STREAM_RESPONSE" | jq -r '.id')
if [ "$STREAM_ID" = "null" ] || [ -z "$STREAM_ID" ]; then
  echo "Error creating stream: $STREAM_RESPONSE"
  exit 1
fi
echo "Stream created: $STREAM_ID"

echo ""
echo "Stream is running! Monitor progress at:"
echo "  ${API_URL}/streams/${STREAM_ID}/progress"
echo ""
echo "Or use: watch -n 1 'curl -s ${API_URL}/streams/${STREAM_ID}/progress | jq'"
