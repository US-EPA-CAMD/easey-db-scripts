#!/bin/bash
source ../../environments.sh $1

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

../../execute-psql.sh "$FILES"

if [ $PRE_DEPLOYMENT == true ]; then
  echo "IMPORTANT: NEED TO GENERATE TOKENS AND LOAD CAMDAUX.CLIENT_CONFIG DATA..."
  echo "
    INSERT INTO camdaux.client_config(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
	  VALUES
      (?, 'campd-ui', ?, ?, ?, 'campd-support@camdsupport.com'),
      (?, 'quartz', ?, ?, ?, null),
      (?, 'xml-ppds', ?, ?, ?, null);
    "
fi

echo "DEPLOYMENT COMPLETE"