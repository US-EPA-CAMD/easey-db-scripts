#!/bin/bash
export PORT=15210
export HOST=localhost
export DB_USER=uImcwuf4K9dyaxeL
export DB_NAME=cgawsbrokerprodr97macy19l

FILES=""
TABLES=false
VIEWS=false
FUNCTIONS=false
PROCEDURES=false
PRE_DATA_LOAD=false
POST_DATA_LOAD=false
PRE_DEPLOYMENT=false
POST_DEPLOYMENT=false

function getFiles() {
  for FILE in $1/*.sql
  do
    FILES="$FILES \i $FILE"
  done
}

if [ $TABLES == true ]; then
  getFiles "./camdmd/tables"
  getFiles "./camd/tables"
fi

if [ $PRE_DEPLOYMENT == true ]; then
  getFiles "../../../camdecmps/views"

  FILES="
    $FILES
    \i ./load-dataset-template-codes.sql
    \i ./load-master-data-definitions.sql
  "
fi

#echo $FILES

psql -h $HOST -p $PORT -d $DB_NAME -U $DB_USER <<-EOSQL
  BEGIN;
    $FILES
  COMMIT;
EOSQL

echo "DEPLOYMENT COMPLETE"