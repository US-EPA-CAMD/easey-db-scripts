#!/bin/bash

sourceDir=$(pwd)
cd ../../../

if [[ -f .env ]]; then
  source .env
fi

cd $sourceDir

case $1 in
  (CDC)
    export PGPORT=$EASEY_PGPORT_CDC
    export PGUSER=$EASEY_PGUSER_CDC
    export PGDB=$EASEY_PGDB_CDC
    ;;
  (DEV)
    export PGPORT=$EASEY_PGPORT_DEV
    export PGUSER=$EASEY_PGUSER_DEV
    export PGDB=$EASEY_PGDB_DEV
    ;;
  (TEST)
    export PGPORT=$EASEY_PGPORT_TEST
    export PGUSER=$EASEY_PGUSER_TEST
    export PGDB=$EASEY_PGDB_TEST
    ;;
  (PERF)
    export PGPORT=$EASEY_PGPORT_PERF
    export PGUSER=$EASEY_PGUSER_PERF
    export PGDB=$EASEY_PGDB_PERF
    ;;
  (BETA)
    export PGPORT=$EASEY_PGPORT_BETA
    export PGUSER=$EASEY_PGUSER_BETA
    export PGDB=$EASEY_PGDB_BETA
    ;;
  (STG)
    export PGPORT=$EASEY_PGPORT_STG
    export PGUSER=$EASEY_PGUSER_STG
    export PGDB=$EASEY_PGDB_STG
    ;;
  (PROD)
    export PGPORT=$EASEY_PGPORT_PROD
    export PGUSER=$EASEY_PGUSER_PROD
    export PGDB=$EASEY_PGDB_PROD
    ;;
  (*)
    echo "ERROR: Unknown environment, cannot properly set env variables!"
    exit 1
    ;;
esac

echo "Using the following connection parameters..."
echo "PGPORT=$PGPORT"
echo "PGUSER=$PGUSER"
echo "PGDB=$PGDB"