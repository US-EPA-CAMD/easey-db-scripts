ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_eval_status_code;
	
ALTER TABLE IF EXISTS camdecmpswks.test_summary
    DROP CONSTRAINT IF EXISTS fk_test_summary_eval_status_code;

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.test_summary
    DROP COLUMN IF EXISTS eval_status_cd;
