#!/bin/bash
source ../../environments.sh $1

FILES=""
TABLES=false
VIEWS=false
FUNCTIONS=false
PROCEDURES=false
BEFORE_DATA_LOAD=true
AFTER_DATA_LOAD=false
POST_DEPLOYMENT_CLEANUP=false

function getFiles() {
  for FILE in $1/*.sql
  do
    FILES="$FILES \i $FILE"
  done
}

function createTables() {
  FILES="$FILES
  \i ./create-schemas.sql
  "

  getFiles "../../../camdmd/tables"
  getFiles "../../../camdecmpsmd/tables"
  getFiles "../../../camd/tables"
  getFiles "../../../camdaux/tables"
  getFiles "../../../camdecmps/tables"
  getFiles "../../../camdecmps/tables/emission-views"
  getFiles "../../../camdecmpswks/tables"
  getFiles "../../../camdecmpswks/tables/emission-views"
  getFiles "../../../camdecmpsaux/tables"
  getFiles "../../../camdecmpscalc/tables"
}

function createOrReplaceViews() {
  getFiles "../../../camdmd/views"
  getFiles "../../../camdecmpsmd/views"
  getFiles "../../../camd/views"
  getFiles "../../../camdaux/views"
  getFiles "../../../camdecmps/views"
  getFiles "../../../camdecmpsaux/views"
  getFiles "../../../camdecmpswks/views"
  getFiles "../../../camdecmpscalc/views"
}

function createOrReplaceFunctions() {
  getFiles "../../../camdmd/functions"
  getFiles "../../../camdecmpsmd/functions"
  getFiles "../../../camd/functions"
  getFiles "../../../camdaux/functions"
  getFiles "../../../camdecmps/functions"
  getFiles "../../../camdecmpsaux/functions"
  getFiles "../../../camdecmpswks/functions"
  getFiles "../../../camdecmpscalc/functions"
}

function createOrReplaceProcedures() {
  getFiles "../../../camdmd/procedures"
  getFiles "../../../camdecmpsmd/procedures"
  getFiles "../../../camd/procedures"
  getFiles "../../../camdaux/procedures"
  getFiles "../../../camdecmps/procedures"
  getFiles "../../../camdecmpsaux/procedures"
  getFiles "../../../camdecmpswks/procedures"
  getFiles "../../../camdecmpscalc/procedures"
}

if [ $TABLES == true ]; then
  createTables
fi

if [ $FUNCTIONS == true ]; then
  createOrReplaceFunctions
fi

if [ $PROCEDURES == true ]; then
  createOrReplaceProcedures
fi

if [ $VIEWS == true ]; then
  createOrReplaceViews
fi

if [ $BEFORE_DATA_LOAD == true ]; then
  createTables

  FILES="$FILES
  \i ./before-data-load.sql
  "
fi

if [ $AFTER_DATA_LOAD == true ]; then
  FILES="\i ./after-data-load.sql
  \i ./load-master-data-definitions.sql
  \i ./load-mdm-relationships-definitions.sql
  "
  
  getFiles "./mdm-relationships"
  getFiles "./report-definitions"
  getFiles "./emissions-view-definitions"

  FILES="$FILES
  \i ./check-tables/PopulateCheckTables.sql
  \i ./client-tables/PopulateClientOnlyTables.sql
  \i ./check-tables/mp-check-catalog-process-load.sql
  \i ./check-tables/qa-check-catalog-process-load.sql
  \i ./check-tables/import-check-catalog-process-load.sql
  "

  createOrReplaceFunctions
  createOrReplaceProcedures
  createOrReplaceViews
fi

if [ $POST_DEPLOYMENT_CLEANUP == true ]; then
  echo "nothing here to do yet"
fi

../../execute-psql.sh "$FILES"

echo "IMPORTANT: NEED TO GENERATE TOKENS AND LOAD CAMDAUX.CLIENT_CONFIG DATA...

INSERT INTO camdaux.client_config(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
VALUES
  (?, 'ecmps-ui', ?, ?, ?, '????');

***** DEPLOYMENT COMPLETE *****
"
