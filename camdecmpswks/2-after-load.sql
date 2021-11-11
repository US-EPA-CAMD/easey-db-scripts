--------------------------------------------------
-- MONITOR PLAN
--------------------------------------------------
ALTER TABLE camdecmpswks.monitor_plan
    ADD COLUMN eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';

UPDATE camdecmpswks.monitor_plan
SET eval_status_cd = 'INQ'
WHERE fac_id = 1;

UPDATE camdecmpswks.monitor_plan
SET eval_status_cd = 'WIP'
WHERE fac_id = 2;

UPDATE camdecmpswks.monitor_plan
SET eval_status_cd = 'PASS'
WHERE fac_id = 3;

UPDATE camdecmpswks.monitor_plan
SET eval_status_cd = 'ERR'
WHERE fac_id = 4;

UPDATE camdecmpswks.monitor_plan
SET eval_status_cd = 'INFO'
WHERE fac_id = 5;

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    ADD CONSTRAINT fk_monitor_plan_eval_status_code FOREIGN KEY (eval_status_cd)
    REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE