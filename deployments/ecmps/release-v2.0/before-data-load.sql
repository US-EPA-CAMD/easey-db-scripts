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
--------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdmd.account_type_code
    DROP CONSTRAINT IF EXISTS fk_account_type_account_type_group;
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
    DROP CONSTRAINT IF EXISTS fk_unit_type_unit_type_group;

ALTER TABLE IF EXISTS camdmd.unit_type_code
    DROP COLUMN IF EXISTS unit_type_group_cd;
-------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.test_summary
    DROP CONSTRAINT IF EXISTS fk_test_summary_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.emission_evaluation
    DROP CONSTRAINT IF EXISTS fk_emission_evaluation_eval_status_code;

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
--ALTER TABLE IF EXISTS camdecmps.dm_emissions
--    DROP COLUMN IF EXISTS fac_id;
--------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access
    ALTER COLUMN em_sub_access_id DROP IDENTITY IF EXISTS;

ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access
    DROP CONSTRAINT IF EXISTS em_submission_access_r04,--camdecmps.monitor_plan
	  DROP CONSTRAINT IF EXISTS fk_em_status_cod_em_submission,
	  DROP CONSTRAINT IF EXISTS fk_em_sub_type_c_em_submission;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpswks.check_session
    DROP COLUMN IF EXISTS batch_id;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.test_type_code
    DROP COLUMN IF EXISTS group_cd;

ALTER TABLE IF EXISTS camdecmpsmd.test_type_code
    DROP CONSTRAINT IF EXISTS fk_test_type_code_group_code;
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpswks.user_check_out
	DROP CONSTRAINT IF EXISTS pk_user_check_out,
	DROP CONSTRAINT IF EXISTS uq_user_checkout_out;

ALTER TABLE IF EXISTS camdecmpswks.user_check_out
	ADD CONSTRAINT pk_user_check_out PRIMARY KEY (mon_plan_id);
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.es_spec
	ALTER COLUMN es_spec_id DROP IDENTITY IF EXISTS;
	
ALTER TABLE IF EXISTS camdecmpsaux.es_spec
	ALTER COLUMN es_spec_id TYPE numeric(38,0);
--------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsmd.es_match_data_type_code
    DROP COLUMN IF EXISTS es_match_data_type_url;
--------------------------------------------------------------------------------------------------------------------
/* NEW MATS REQ
ALTER TABLE IF EXISTS camdecmps.test_summary
    DROP COLUMN IF EXISTS aps_formula_used_cd,
    DROP COLUMN IF EXISTS instrument_span;

ALTER TABLE IF EXISTS camdecmpswks.test_summary
    DROP COLUMN IF EXISTS aps_formula_used_cd,
    DROP COLUMN IF EXISTS instrument_span;
NEW MATS REQ */
--------------------------------------------------------------------------------------------------------------------
