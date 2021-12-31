--EVALUATION_STATUS_CODE
--need to drop the relationship in order to reload data
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_eval_status_code;

ALTER TABLE IF EXISTS camdecmpsmd.severity_code
    DROP COLUMN IF EXISTS eval_status_cd;

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
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