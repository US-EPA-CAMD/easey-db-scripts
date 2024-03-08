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

  FILES="$FILES
    \i ../../../../camdaux/views/vw_allowance_based_compliance_bulk_files_to_generate.sql
  "

echo $PWD
  ../../execute-psql.sh "$FILES"
fi

echo "
***** DEPLOYMENT COMPLETE *****
"
