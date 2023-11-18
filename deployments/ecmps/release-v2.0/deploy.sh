#!/bin/bash
FILES=""
source ../../environments.sh $1

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

  FILES="$FILES
  \i ../../../camdecmps/partitions/create-partitions.sql
  "
}

function createOrReplaceViews() {
  getFiles "../../../camdecmpsmd/views"
  getFiles "../../../camdaux/views"
  getFiles "../../../camdecmps/views"
  getFiles "../../../camdecmpswks/views"
  #getFiles "../../../camdecmpsaux/views" #causing errors unless run in POST_DEPLOYMENT
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

function dropConstraintsIndexes() {
  schemas=(
    camdecmpscalc
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
}

if [ $2 == "REFRESH_FUNCS_PROCS" ]; then
  FILES="$FILES
  \i ../../../camdecmps/functions/get_derived_hourly_values_pivoted.sql
  \i ../../../camdecmps/functions/get_hourly_param_fuel_flow_pivoted.sql
  \i ../../../camdecmps/functions/get_monitor_hourly_values_pivoted.sql
  \i ../../../camdecmps/procedures/load_temp_daily_test_errors.sql
  \i ../../../camdecmps/procedures/load_temp_hour_rules.sql
  \i ../../../camdecmps/procedures/load_temp_hourly_test_errors.sql
  \i ../../../camdecmps/procedures/load_temp_weekly_test_errors.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_all.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_co2appd.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_co2calc.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_co2cems.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_co2dailyfuel.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_count.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_dailybackstop.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_dailycal.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_hiappd.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_hicems.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_hiunitstack.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_lme.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_ltff.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_massoilcalc.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_matshcl.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_matshf.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_matshg.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_matsso2.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_matssorbent.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_matsweekly.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_moisture.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_noxappemixedfuel.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_noxappesinglefuel.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_noxmasscems.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_noxratecems.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_nsps4t.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_otherdaily.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_so2appd.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_so2cems.sql
  \i ../../../camdecmps/procedures/refresh_emission_view_sumval.sql
  \i ../../../camdecmps/procedures/refresh_emissions_views.sql
  \i ../../../camdecmpswks/functions/get_derived_hourly_values_pivoted.sql
  \i ../../../camdecmpswks/functions/get_hourly_param_fuel_flow_pivoted.sql
  \i ../../../camdecmpswks/functions/get_monitor_hourly_values_pivoted.sql
  \i ../../../camdecmpswks/procedures/load_temp_daily_test_errors.sql
  \i ../../../camdecmpswks/procedures/load_temp_hour_rules.sql
  \i ../../../camdecmpswks/procedures/load_temp_hourly_test_errors.sql
  \i ../../../camdecmpswks/procedures/load_temp_weekly_test_errors.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_all.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_co2appd.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_co2calc.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_co2cems.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_co2dailyfuel.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_count.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_dailybackstop.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_dailycal.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_hiappd.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_hicems.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_hiunitstack.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_lme.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_ltff.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_massoilcalc.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_matshcl.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_matshf.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_matshg.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_matsso2.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_matssorbent.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_matsweekly.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_moisture.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_noxappemixedfuel.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_noxappesinglefuel.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_noxmasscems.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_noxratecems.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_nsps4t.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_otherdaily.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_so2appd.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_so2cems.sql
  \i ../../../camdecmpswks/procedures/refresh_emission_view_sumval.sql
  \i ../../../camdecmpswks/procedures/refresh_emissions_views.sql
  "
  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "TABLES" ]; then
  FILES="CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
  createTables
  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "FUNCTIONS" ]; then
  createOrReplaceFunctions
  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "PROCEDURES" ]; then
  createOrReplaceProcedures
  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "VIEWS" ]; then
  createOrReplaceViews
  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "PRE_DATA_LOAD" ]; then
  FILES="$FILES
  TRUNCATE TABLE camdecmps.dm_emissions;
  TRUNCATE TABLE camdecmps.emission_evaluation;
  TRUNCATE TABLE camdecmpsaux.em_submission_access;  
  \i ./drop-customizations.sql
  \i ./update-userid-length.sql
  "

  dropConstraintsIndexes
  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "POST_DATA_LOAD" ]; then
  FILES="$FILES
  TRUNCATE camdaux.DATASET;
  TRUNCATE camdaux.DATATABLE;
  TRUNCATE camdaux.DATACOLUMN;
  TRUNCATE camdaux.DATAPARAMETER;
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
  DELETE FROM camdecmps.dm_emissions_user WHERE dm_emissions_user_cd NOT IN ('S3QTRFILES','S3STATEFILES');
  DELETE FROM camdecmps.dm_emissions_user WHERE dm_emissions_id NOT IN (SELECT dm_emissions_id FROM camdecmps.dm_emissions);
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

if [ $2 == "DROP_CONSTRAINTS_INDEXES" ]; then
  dropConstraintsIndexes
  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "ADD_CONSTRAINTS_INDEXES" ]; then
  # THESE ARE ALL PRETTY QUICK
  #getFilesAndCommit "../../../camdmd/constraints-indexes"
  #getFilesAndCommit "../../../camdecmpsmd/constraints-indexes"
  #getFilesAndCommit "../../../camd/constraints-indexes"
  #getFilesAndCommit "../../../camdaux/constraints-indexes"
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group1"

  # CAN TAKE MANY HOURS
  #getFileAndCommit "../../../camdecmps/constraints-indexes/3-hrly_op_data.sql"

  # THESE ARE ALL PRETTY QUICK
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group2"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/3-operating_supp_data.sql"
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group3"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/4-daily_test_summary.sql"

  # CAN TAKE MANY HOURS
  #getFileAndCommit "../../../camdecmps/constraints-indexes/4-derived_hrly_value.sql"

  # CAN TAKE MANY HOURS
  #getFileAndCommit "../../../camdecmps/constraints-indexes/4-hrly_fuel_flow.sql"

  # CAN TAKE MANY HOURS
  #getFileAndCommit "../../../camdecmps/constraints-indexes/4-hrly_gas_flow_meter.sql"

  # THIS ONE IS QUICK
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group4"

  # CAN TAKE MANY HOURS
  #getFileAndCommit "../../../camdecmps/constraints-indexes/4-mats_derived_hrly_value.sql"

  # CAN TAKE MANY HOURS
  #getFileAndCommit "../../../camdecmps/constraints-indexes/4-mats_monitor_hrly_value.sql"

  # CAN TAKE MANY HOURS
  #getFileAndCommit "../../../camdecmps/constraints-indexes/4-monitor_hrly_value.sql"

  # THESE ARE ALL PRETTY QUICK
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group5"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/4-test_summary.sql"
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group6"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/5-daily_calibration.sql"
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group7"

  # CAN TAKE MANY HOURS
  #getFileAndCommit "../../../camdecmps/constraints-indexes/5-hrly_param_fuel_flow.sql"

  # THESE ARE ALL PRETTY QUICK
  #getFileAndCommit "../../../camdecmps/constraints-indexes/5-linearity_summary.sql"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/5-on_off_cal.sql"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/5-protocol_gas.sql"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/5-qa_cert_event_supp_data.sql"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/5-qa_supp_data.sql"
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group8"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/6-linearity_injection.sql"
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group9"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/7-rata_run.sql"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/8-flow_rata_run.sql"
  #getFileAndCommit "../../../camdecmps/constraints-indexes/9-rata_traverse.sql"
  #getFilesAndCommit "../../../camdecmps/constraints-indexes/group10"
  #getFilesAndCommit "../../../camdecmpsaux/constraints-indexes"
  #getFilesAndCommit "../../../camdecmpswks/constraints-indexes"
  getFilesAndCommit "../../../camdecmpscalc/constraints-indexes"
fi

if [ $2 == "POST_DEPLOYMENT_CLEANUP" ]; then
  getFiles "../../../camdecmpsaux/views"

  FILES="$FILES
  DROP TABLE IF EXISTS camdaux.bulk_file_log CASCADE;
  DROP TABLE IF EXISTS camdaux.dataset_template CASCADE;
  DROP TABLE IF EXISTS camdaux.missing_oris CASCADE;
  DROP TABLE IF EXISTS camdaux.sftp_failures CASCADE;
  DROP TABLE IF EXISTS camdaux.sftp_log CASCADE;
  \i ./update-mp-qa-em-check-session-ids.sql
  CALL camdecmpswks.load_workspace();
  "

  ../../execute-psql.sh "$FILES"
fi

if [ $2 == "ROLLBACK" ]; then
  # FILES="# place rollback script(s) here"
  ../../execute-psql.sh "$FILES"
fi

echo "IMPORTANT: NEED TO GENERATE TOKENS AND LOAD CAMDAUX.CLIENT_CONFIG DATA...

INSERT INTO camdaux.client_config(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
VALUES
  (?, 'ecmps-ui', ?, ?, ?, '????');

***** DEPLOYMENT COMPLETE *****
"
