#!/bin/bash
FILES=""
source ../../environments.sh $1

function getFiles() {
  for FILE in $1/*.sql
  do
    FILES="$FILES \i $FILE"
  done
}

if [ $2 == "PRE_DEPLOYMENT" ]; then
  getFiles "../../../camddmw/views"
  getFiles "../../../camdecmps/views"

  getFiles "../../../camdaux/tables"
  getFiles "../../../camdaux/functions"
  getFiles "../../../camdaux/procedures"
  getFiles "../../../camdaux/views"

  FILES="$FILES
    \i ./load-dataset-template-codes.sql
    \i ./load-master-data-definitions.sql
    \i ./update-bulk-file-active-active-prg.sql
  "

  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "POST_DEPLOYMENT" ]; then
  FILES="$FILES
    \i ./drop-camddmw-objects.sql
    \i ./drop-camdaux-objects.sql
  "

  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "AFTER_BULK_FILE_LOAD" ]; then
  FILES="$FILES
    \i ./update-bulk-file-active-inactive-prg.sql
  "

  ../../execute-psql.sh "$FILES"
fi

echo "IMPORTANT: NEED TO GENERATE TOKENS AND LOAD CAMDAUX.CLIENT_CONFIG DATA...

INSERT INTO camdaux.client_config(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
VALUES
  (?, 'campd-ui', ?, ?, ?, 'campd-support@camdsupport.com'),
  (?, 'quartz', ?, ?, ?, null),
  (?, 'xml-ppds', ?, ?, ?, null);

***** DEPLOYMENT COMPLETE *****
"