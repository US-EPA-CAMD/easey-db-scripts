DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_progress;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_expected;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_received;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_gdm;
DROP VIEW IF EXISTS camdecmpswks.vw_em_review_and_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_review_and_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_test_summary_eval_and_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_cert_event_eval_and_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_test_extension_exemption_eval_and_submit;
DROP VIEW IF EXISTS camdaux.vw_allowance_based_compliance_bulk_files_to_generate;
DROP VIEW IF EXISTS camdaux.vw_annual_emissions_bulk_files_per_state_to_generate;
DROP VIEW IF EXISTS camdecmpsmd.vw_es_check_catalog_result;
DROP VIEW IF EXISTS camdecmpswks.vw_em_eval_and_submit;
--------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS emissions_ui_filter;

ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS allowance_ui_filter;

ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS compliance_ui_filter;

ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS rue_ind;

ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS so2_cert_ind;

ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS nox_cert_ind;

ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS noxc_cert_ind;

ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS notes;

ALTER TABLE IF EXISTS camdmd.program_code
    DROP COLUMN IF EXISTS bulk_file_active;
--------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdmd.unit_type_code
    DROP COLUMN IF EXISTS unit_type_group_cd;
-------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.severity_code
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.test_summary
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.emission_evaluation 
    DROP COLUMN IF EXISTS eval_status_cd;
--------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.process_code
    DROP COLUMN IF EXISTS process_cd_name;

ALTER TABLE IF EXISTS camdecmpsmd.process_code
    DROP COLUMN IF EXISTS parameter_group_override_cd;

ALTER TABLE IF EXISTS camdecmpsmd.process_code
    DROP COLUMN IF EXISTS process_group_cd;
--------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.qual_type_code
    DROP COLUMN IF EXISTS qual_type_group_cd;
--------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access
    ALTER COLUMN em_sub_access_id DROP IDENTITY IF EXISTS;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpswks.check_session
    DROP COLUMN IF EXISTS batch_id;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.test_type_code
    DROP COLUMN IF EXISTS group_cd;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.es_spec
	ALTER COLUMN es_spec_id DROP IDENTITY IF EXISTS;
	
ALTER TABLE IF EXISTS camdecmpsaux.es_spec
	ALTER COLUMN es_spec_id TYPE numeric(38,0);
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.es_match_data_type_code
    DROP COLUMN IF EXISTS es_match_data_type_url;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.component
	DROP COLUMN IF EXISTS analytical_principle_cd;

ALTER TABLE IF EXISTS camdecmpswks.component
 	DROP COLUMN IF EXISTS analytical_principle_cd;
--------------------------------------------------------------------------------------------------------------------
DO $$
BEGIN
  IF EXISTS(
    SELECT * FROM information_schema.columns
    WHERE table_schema = 'camdaux' AND table_name = 'dataset' AND column_name = 'group_cd'
  ) THEN
    ALTER TABLE IF EXISTS camdaux.dataset
      ADD COLUMN IF NOT EXISTS template_cd character varying(25);

    UPDATE camdaux.dataset SET template_cd = 
      CASE
        WHEN group_cd = 'REPORT' THEN 'DTLRPT'
        ELSE group_cd
      END;
  END IF;
END $$;