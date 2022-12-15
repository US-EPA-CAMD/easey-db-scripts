#!/bin/bash
export PORT=15210
export HOST=localhost
export DB_USER=uImcwuf4K9dyaxeL
export DB_NAME=cgawsbrokerprodr97macy19l

FILES=""
PRE_DEPLOYMENT=false
POST_DEPLOYMENT=false
AFTER_BULK_FILE_LOAD=false

function getFiles() {
  for FILE in $1/*.sql
  do
    FILES="$FILES \i $FILE"
  done
}

if [ $PRE_DEPLOYMENT == true ]; then
  getFiles "../../../camddmw/views"
  getFiles "../../../camdecmps/views"

  getFiles "../../../camdaux/tables"
  getFiles "../../../camdaux/functions"
  getFiles "../../../camdaux/procedures"
  getFiles "../../../camdaux/views"

  FILES="
    $FILES
    \i ./load-dataset-template-codes.sql
    \i ./load-master-data-definitions.sql
    \i ./update-bulk-file-active-active-prg.sql
  "
fi

if [ $POST_DEPLOYMENT == true ]; then
  FILES="
    $FILES
    \i ./drop-camddmw-objects.sql
    \i ./drop-camdaux-objects.sql
  "
fi

if [ $AFTER_BULK_FILE_LOAD == true ]; then
  FILES="
    $FILES
    \i ./update-bulk-file-active-inactive-prg.sql
  "
fi

#echo $FILES

psql -h $HOST -p $PORT -d $DB_NAME -U $DB_USER <<-EOSQL
  BEGIN;
    $FILES
  COMMIT;
EOSQL

if [ $PRE_DEPLOYMENT == true ]; then
  echo "NEED TO GENERATE AND LOAD CAMDAUX.CLIENT_CONFIG DATA"
fi

echo "DEPLOYMENT COMPLETE"