-- MONITOR_PLAN
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_eval_status_code;

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    DROP COLUMN IF EXISTS eval_status_cd;

