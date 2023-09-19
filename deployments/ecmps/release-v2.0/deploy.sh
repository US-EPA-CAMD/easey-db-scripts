#!/bin/bash
source ../../environments.sh $1

FILES=""
TABLES=false
VIEWS=false
FUNCTIONS=true
PROCEDURES=false
PRE_DATA_LOAD=false
POST_DATA_LOAD=false
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
  getFiles "../../../camdecmpsmd/views"
  getFiles "../../../camdaux/views"
  getFiles "../../../camdecmps/views"
  getFiles "../../../camdecmpsaux/views"
  getFiles "../../../camdecmpswks/views"
}

function createOrReplaceFunctions() {
  getFiles "../../../camdaux/functions"
  getFiles "../../../camdecmps/functions"
  getFiles "../../../camdecmpsaux/functions"
  getFiles "../../../camdecmpswks/functions"
}

function createOrReplaceProcedures() {
  getFiles "../../../camdaux/procedures"
  getFiles "../../../camdecmps/procedures"
  getFiles "../../../camdecmpsaux/procedures"
  getFiles "../../../camdecmpswks/procedures"
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

if [ $PRE_DATA_LOAD == true ]; then
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

if [ $POST_DATA_LOAD == true ]; then
  FILES="$FILES
  TRUNCATE camdecmpsmd.CHECK_CATALOG_PARAMETER;
  TRUNCATE camdecmpsmd.CHECK_CATALOG_PLUGIN;
  TRUNCATE camdecmpsmd.CHECK_CATALOG_PROCESS;
  TRUNCATE camdecmpsmd.CHECK_PARAMETER_CODE;
  TRUNCATE camdecmpsmd.RESPONSE_CATALOG;
  \copy camdecmpsmd.check_catalog_parameter from './check-tables/data/check_catalog_parameter.csv' with delimiter '|' CSV HEADER QUOTE '\"' ESCAPE '\"';
  \copy camdecmpsmd.check_catalog_plugin from './check-tables/data/check_catalog_plugin.csv' with delimiter '|' CSV HEADER QUOTE '\"' ESCAPE '\"';
  \copy camdecmpsmd.check_parameter_code from './check-tables/data/check_parameter_code.csv' with delimiter '|' CSV HEADER QUOTE '\"' ESCAPE '\"';
  \copy camdecmpsmd.response_catalog from './check-tables/data/response_catalog.csv' with delimiter '|' CSV HEADER QUOTE '\"' ESCAPE '\"';
  DELETE FROM camdecmpsmd.check_catalog_result WHERE check_catalog_result_id = 5849;
  \i ./check-tables/PopulateCheckTables.sql
  \i ./client-tables/PopulateClientOnlyTables.sql
  \i ./drop-customizations.sql
  \i ./add-customizations.sql
  \i ./load-additional-mdm-data.sql
  \i ./load-master-data-definitions.sql
  \i ./load-mdm-relationships-definitions.sql
  \i ./check-tables/mp-check-catalog-process-load.sql
  \i ./check-tables/qa-check-catalog-process-load.sql
  \i ./check-tables/import-check-catalog-process-load.sql
  \i ../../../camdecmpsmd/views/vw_cross_check_catalog_value.sql
  "

  getFiles "./mdm-relationships"
  getFiles "./report-definitions"
  getFiles "./emissions-view-definitions"

  createOrReplaceFunctions
  createOrReplaceViews
  createOrReplaceProcedures
fi

if [ $POST_DEPLOYMENT_CLEANUP == true ]; then
  getFiles "../../../camdmd/constraints-indexes"
  getFiles "../../../camdecmpsmd/constraints-indexes"
  getFiles "../../../camd/constraints-indexes"
  getFiles "../../../camdaux/constraints-indexes"
  getFiles "../../../camdecmps/constraints-indexes"
  getFiles "../../../camdecmpsaux/constraints-indexes"
  getFiles "../../../camdecmpswks/constraints-indexes"

  FILES="$FILES
  CALL camdecmpswks.camdecmpswks.load_workspace();
  \i ../../../camdecmps/partitions/create-emission_view-partitions.sql
  CALL camdecmps.refresh_emissions_views();
  "
fi

../../execute-psql.sh "$FILES"

echo "IMPORTANT: NEED TO GENERATE TOKENS AND LOAD CAMDAUX.CLIENT_CONFIG DATA...

INSERT INTO camdaux.client_config(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
VALUES
  (?, 'ecmps-ui', ?, ?, ?, '????');

NOTE: RUN THE POST_DEPLOYMENT_CLEANUP TO...
  - ADD CONSTRAINTS & INDEXES
  - LOAD WORKSPACE DATA
  - CREATE EMISSIONS VIEW PARTITIONS (OFFICIAL SCHEMA)
  - LOAD EMISSIONS VIEW DATA (OFFICIAL SCHEMA)

***** DEPLOYMENT COMPLETE *****
"
