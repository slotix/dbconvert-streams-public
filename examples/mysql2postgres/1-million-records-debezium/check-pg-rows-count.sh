#!/bin/bash

POSTGRES_USER=$1
POSTGRES_PASSWORD=$2
POSTGRES_DB=$3
limit=1000000

while true
do
  processed=$(docker-compose exec postgres-target bash -c "psql -U $POSTGRES_USER $POSTGRES_DB -c \"select count(*) from products\"" | head -n 3 | grep -o '[0-9]\+')
  if [ $processed -gt $limit ]; 
      then
        echo "Processed 1 Mln records. Current time: $(date +%T)"
        break
      else  
        echo "# of processed records: $processed"
  fi
  sleep 2
done
