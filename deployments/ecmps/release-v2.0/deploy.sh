#!/bin/bash
source ../../environments.sh $1

FILES=""
TABLES=false
VIEWS=false
FUNCTIONS=false
PROCEDURES=false
PRE_DEPLOYMENT=false
POST_DEPLOYMENT=false
BEFORE_DATA_LOAD=false
AFTER_DATA_LOAD=false

function getFiles() {
  for FILE in $1/*.sql
  do
    FILES="$FILES \i $FILE"
  done
}

function createTables() {
  getFiles "../../../camdmd/tables"
  getFiles "../../../camdecmpsmd/tables"
  getFiles "../../../camd/tables"
  getFiles "../../../camdaux/tables"
  getFiles "../../../camdecmps/tables"
  getFiles "../../../camdecmpsaux/tables"
  getFiles "../../../camdecmpswks/tables"
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

if [ $PRE_DEPLOYMENT == true ]; then
  createTables
  createOrReplaceFunctions
  createOrReplaceProcedures
  createOrReplaceViews

  FILES="
    $FILES
    \i ./load-dataset-template-codes.sql
    \i ./load-master-data-definitions.sql
  "
  getFiles "./mdm-relationships"
  getFiles "./report-definitions"
  getFiles "./emissions-view-definitions"
fi

if [ $POST_DEPLOYMENT == true ]; then
  echo "nothing here to do yet"
fi

if [ $BEFORE_DATA_LOAD == true ]; then
  FILES="\i ./before-data-load.sql"
fi

if [ $AFTER_DATA_LOAD == true ]; then
  FILES="\i ./after-data-load.sql"
  FILES="$FILES 
  \i ../../../camdaux/vw_allowance_based_compliance_bulk_files_to_generate.sql
  \i ../../../camdaux/vw_annual_emissions_bulk_files_per_state_to_generate.sql
  \i ../../../camdecmps/vw_emissions_submissions_gdm.sql
  \i ../../../camdecmps/vw_emissions_submissions_expected.sql
  \i ../../../camdecmps/vw_emissions_submissions_received.sql
  \i ../../../camdecmps/vw_emissions_submissions_progress.sql
  \i ../../../camdecmpswks/vw_qa_test_summary_review_and_submit.sql
  \i ../../../camdecmpswks/1-vw_em_review_and_submit.sql
  "
fi

../../execute-psql.sh "$FILES"

if [ $PRE_DEPLOYMENT == true ]; then
  echo "IMPORTANT: NEED TO GENERATE TOKENS AND LOAD CAMDAUX.CLIENT_CONFIG DATA..."
  echo "
    INSERT INTO camdaux.client_config(client_id, client_name, client_secret, client_passcode, encryption_key, support_email)
	  VALUES
      (?, 'ecmps-ui', ?, ?, ?, '????');
    "
fi

echo "DEPLOYMENT COMPLETE"