--EVALUATION_STATUS_CODE
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.test_summary
    DROP CONSTRAINT IF EXISTS fk_test_summary_eval_status_code;

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

DROP TABLE IF EXISTS camdecmpsmd.eval_status_code;


-- PROCESS_CODE
ALTER TABLE IF EXISTS camdecmpsmd.process_code
    DROP COLUMN IF EXISTS process_cd_name;

ALTER TABLE IF EXISTS camdecmpsmd.process_code
    DROP COLUMN IF EXISTS parameter_group_override_cd;

ALTER TABLE IF EXISTS camdecmpsmd.process_code
    DROP COLUMN IF EXISTS process_group_cd;


-- QUAL_TYPE_CODE
ALTER TABLE IF EXISTS camdecmpsmd.qual_type_code
    DROP COLUMN IF EXISTS qual_type_group_cd;