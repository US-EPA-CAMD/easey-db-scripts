#!/bin/bash
case $1 in
  (CDC)
    export PGPORT=$EASEY_PGPORT_CDC
    export PGHOST=$EASEY_PGHOST_CDC
    export PGUSER=$EASEY_PGUSER_CDC
    export PGPWD=$EASEY_PGPWD_CDC
    export PGDB=$EASEY_PGDB_CDC
    ;;
  (DEV)
    export PGPORT=$EASEY_PGPORT_DEV
    export PGHOST=$EASEY_PGHOST_DEV
    export PGUSER=$EASEY_PGUSER_DEV
    export PGPWD=$EASEY_PGPWD_DEV
    export PGDB=$EASEY_PGDB_DEV
    ;;
  (TEST)
    export PGPORT=$EASEY_PGPORT_TEST
    export PGHOST=$EASEY_PGHOST_TEST
    export PGUSER=$EASEY_PGUSER_TEST
    export PGPWD=$EASEY_PGPWD_TEST
    export PGDB=$EASEY_PGDB_TEST
    ;;
  (PERF)
    export PGPORT=$EASEY_PGPORT_PERF
    export PGHOST=$EASEY_PGHOST_PERF
    export PGUSER=$EASEY_PGUSER_PERF
    export PGPWD=$EASEY_PGPWD_PERF
    export PGDB=$EASEY_PGDB_PERF
    ;;
  (BETA)
    export PGPORT=$EASEY_PGPORT_BETA
    export PGHOST=$EASEY_PGHOST_BETA
    export PGUSER=$EASEY_PGUSER_BETA
    export PGPWD=$EASEY_PGPWD_BETA
    export PGDB=$EASEY_PGDB_BETA
    ;;
  (STG)
    export PGPORT=$EASEY_PGPORT_STG
    export PGHOST=$EASEY_PGHOST_STG
    export PGUSER=$EASEY_PGUSER_STG
    export PGPWD=$EASEY_PGPWD_STG
    export PGDB=$EASEY_PGDB_STG
    ;;
  (PROD)
    export PGPORT=$EASEY_PGPORT_PROD
    export PGHOST=$EASEY_PGHOST_PROD
    export PGUSER=$EASEY_PGUSER_PROD
    export PGPWD=$EASEY_PGPWD_PROD
    export PGDB=$EASEY_PGDB_PROD
    ;;
  (*)
    echo "ERROR: Unknown environment, cannot properly set env variables!"
    exit 1
    ;;
esac

echo "Using the following connection parameters..."
echo "PGPORT=$PGPORT"
echo "PGHOST=$PGHOST"
echo "PGUSER=$PGUSER"
echo "PGPWD=$PGPWD"
echo "PGDB=$PGDB"