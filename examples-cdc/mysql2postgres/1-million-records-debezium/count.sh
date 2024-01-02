#!/bin/bash

count=0
start_time=0
while true; do
  output=$(docker compose exec postgres-target bash -c "psql -U \$POSTGRES_USER \$POSTGRES_DB -c 'select count(*) from products'")
  count=$(echo "$output" | sed -n '3p' | awk '{print $1}')
  if [[ $count -gt 1 && $start_time -eq 0 ]]; then
    start_time=$(date +%s)
    echo "Started at"
  fi
  if [[ $count -gt 1000000 ]]; then
    end_time=$(date +%s)
    elapsed_time=$((end_time - start_time))
    echo "Record count exceeded 1000000 after $elapsed_time seconds."
    break
  fi
  echo "$output" | sed -n '3p' | awk '{print $1}'
  sleep 1
done
