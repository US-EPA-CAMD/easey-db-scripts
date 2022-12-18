#!/bin/bash
echo "Executing the following commands with psql...$1"

psql -h $PGHOST -p $PGPORT -d $PGDB -U $PGUSER <<-EOSQL
  BEGIN;
    $1
  COMMIT;
EOSQL