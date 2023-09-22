#!/bin/bash
source ../../environments.sh $1

FILES=""
TABLES=false
VIEWS=false
FUNCTIONS=false
PROCEDURES=false
PRE_DATA_LOAD=false
POST_DATA_LOAD=false
CONSTRAINTS_INDEXES=true
POST_DEPLOYMENT_CLEANUP=false

function getFileAndCommit() {
  FILES="\i $1"
  ../../execute-psql.sh "$FILES"
}

function getFilesAndCommit() {
  FILES=""
  getFiles $1
  ../../execute-psql.sh "$FILES"
}

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
  #getFiles "../../../camdecmpsaux/views" having an issue with vw_em_submission_access.sql
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
  ../../execute-psql.sh "$FILES"
fi

if [ $FUNCTIONS == true ]; then
  createOrReplaceFunctions
  ../../execute-psql.sh "$FILES"
fi

if [ $PROCEDURES == true ]; then
  createOrReplaceProcedures
  ../../execute-psql.sh "$FILES"
fi

if [ $VIEWS == true ]; then
  createOrReplaceViews
  ../../execute-psql.sh "$FILES"
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

  #FILES="$FILES
  #\i ../../../camdecmps/partitions/create-emission-view-partitions.sql
  #\i ../../../camdecmps/partitions/create-emission-data-partitions.sql
  #"

  ../../execute-psql.sh "$FILES"
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

  ../../execute-psql.sh "$FILES"
fi

if [ $CONSTRAINTS_INDEXES == true ]; then
  getFilesAndCommit "../../../camdmd/constraints-indexes"
  getFilesAndCommit "../../../camdecmpsmd/constraints-indexes"
  getFilesAndCommit "../../../camd/constraints-indexes"
  getFilesAndCommit "../../../camdaux/constraints-indexes"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group1"
  getFileAndCommit "../../../camdecmps/constraints-indexes/3-hrly_op_data.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group2"
  getFileAndCommit "../../../camdecmps/constraints-indexes/3-operating_supp_data.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group3"
  getFileAndCommit "../../../camdecmps/constraints-indexes/4-daily_test_summary.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/4-derived_hrly_value.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/4-hrly_fuel_flow.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/4-hrly_gas_flow_meter.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group4"
  getFileAndCommit "../../../camdecmps/constraints-indexes/4-mats_derived_hrly_value.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/4-mats_monitor_hrly_value.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/4-monitor_hrly_value.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group5"
  getFileAndCommit "../../../camdecmps/constraints-indexes/4-test_summary.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group6"
  getFileAndCommit "../../../camdecmps/constraints-indexes/5-daily_calibration.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group7"
  getFileAndCommit "../../../camdecmps/constraints-indexes/5-hrly_param_fuel_flow.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/5-linearity_summary.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/5-on_off_cal.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/5-protocol_gas.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/5-qa_cert_event_supp_data.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/5-qa_supp_data.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group8"
  getFileAndCommit "../../../camdecmps/constraints-indexes/6-linearity_injection.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group9"
  getFileAndCommit "../../../camdecmps/constraints-indexes/7-rata_run.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/8-flow_rata_run.sql"
  getFileAndCommit "../../../camdecmps/constraints-indexes/9-rata_traverse.sql"
  getFilesAndCommit "../../../camdecmps/constraints-indexes/group10"
  getFilesAndCommit "../../../camdecmpsaux/constraints-indexes"
  getFilesAndCommit "../../../camdecmpswks/constraints-indexes"
fi

if [ $POST_DEPLOYMENT_CLEANUP == true ]; then
  FILES="
  CALL camdecmpswks.camdecmpswks.load_workspace();
  CALL camdecmps.refresh_emissions_views();
  "
  ../../execute-psql.sh "$FILES"
fi

echo "IMPORTANT: NEED TO GENERATE TOKENS AND LOAD CAMDAUX.CLIENT_CONFIG DATA...

INSERT INTO camdaux.client_config(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
VALUES
  (?, 'ecmps-ui', ?, ?, ?, '????');

***** DEPLOYMENT COMPLETE *****
"
