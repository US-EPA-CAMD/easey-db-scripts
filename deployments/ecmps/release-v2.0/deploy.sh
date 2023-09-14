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
  getFiles "../../../camdecmpswks/tables"
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
  \i ./drop-customizations.sql
  "

  schemas=(
    camdecmpsaux
    camdecmpswks
    camdecmps
    camdaux
    camd
    camdecmpsmd
    camdmd
  )

  for i in "${schemas[@]}"; do
    FILENAME=$i-drop-constraints-indexes.sql
    cp ../../drop-constraints-indexes.sql $FILENAME
    sed -i "s/SCHEMA/$i/g" $FILENAME

    FILES="$FILES
    \i ./$FILENAME
    "
  done
fi

if [ $AFTER_DATA_LOAD == true ]; then
  FILES="$FILES
  \i ./check-tables/PopulateCheckTables.sql
  \i ./client-tables/PopulateClientOnlyTables.sql
  \i ./load-additional-mdm-data.sql
  \i ./add-customizations.sql
  \i ./load-master-data-definitions.sql
  \i ./load-mdm-relationships-definitions.sql
  "

  getFiles "./mdm-relationships"
  getFiles "./report-definitions"
  getFiles "./emissions-view-definitions"

  FILES="$FILES
  \i ./load-mats-2-0-gnp-cross-checks.sql
  \i ./check-tables/mp-check-catalog-process-load.sql
  \i ./check-tables/qa-check-catalog-process-load.sql
  \i ./check-tables/import-check-catalog-process-load.sql
  \i ../../../camdecmps/partitions/create-emission_view-partitions.sql
  "
  createOrReplaceFunctions
  createOrReplaceProcedures
  createOrReplaceViews

  FILES="$FILES
  CALL camdecmps.refresh_emissions_views();
  CALL camdecmpswks.camdecmpswks.load_workspace();
  "
fi

if [ $POST_DEPLOYMENT_CLEANUP == true ]; then
  getFiles "../../../camdmd/constraints-indexes"
  getFiles "../../../camdecmpsmd/constraints-indexes"
  getFiles "../../../camd/constraints-indexes"
  getFiles "../../../camdaux/constraints-indexes"
  getFiles "../../../camdecmps/constraints-indexes"
  getFiles "../../../camdecmpsaux/constraints-indexes"  
  getFiles "../../../camdecmpswks/constraints-indexes"
fi

../../execute-psql.sh "$FILES"
rm *drop-constraints-indexes.sql

echo "IMPORTANT: NEED TO GENERATE TOKENS AND LOAD CAMDAUX.CLIENT_CONFIG DATA...

INSERT INTO camdaux.client_config(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
VALUES
  (?, 'ecmps-ui', ?, ?, ?, '????');

NOTE: RUN THE POST_DEPLOYMENT_CLEANUP OVER NIGHT TO ADD BACK CONSTRAINTS & INDEXES...

***** DEPLOYMENT COMPLETE *****
"
