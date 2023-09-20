-- camdecmps.monitor_plan
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_fac_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_submission;
DROP INDEX IF EXISTS camdecmps.monitor_plan_idx001;
DROP INDEX IF EXISTS camdecmps.monitor_plan_idx002;
DROP INDEX IF EXISTS camdecmps.monitor_plan_idx003;

DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_chk_sessio;
CREATE INDEX IF NOT EXISTS idx_monitor_plan_chk_session
    ON camdecmps.monitor_plan USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_submission1;
CREATE INDEX IF NOT EXISTS idx_monitor_plan_submission
    ON camdecmps.monitor_plan USING btree
    (submission_id ASC NULLS LAST);

-- camdecmpswks.monitor_plan
DROP INDEX IF EXISTS camdecmpswks.idx_monitor_plan_fac_id;
DROP INDEX IF EXISTS camdecmpswks.idx_monitor_plan_submission;
DROP INDEX IF EXISTS camdecmpswks.monitor_plan_idx001;
DROP INDEX IF EXISTS camdecmpswks.monitor_plan_idx002;
DROP INDEX IF EXISTS camdecmpswks.monitor_plan_idx003;

DROP INDEX IF EXISTS camdecmpswks.idx_monitor_plan_chk_sessio;
CREATE INDEX IF NOT EXISTS idx_monitor_plan_chk_session
    ON camdecmpswks.monitor_plan USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

DROP INDEX IF EXISTS camdecmpswks.idx_monitor_plan_submission1;
CREATE INDEX IF NOT EXISTS idx_monitor_plan_submission
    ON camdecmpswks.monitor_plan USING btree
    (submission_id ASC NULLS LAST);

-- camdecmps.hrly_param_fuel_flow
ALTER TABLE IF EXISTS camdecmps.hrly_param_fuel_flow
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_hrly_fuel_flow_id_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_hrly_fuel_flow_id_check1,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_hrly_param_ff_id_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_hrly_param_ff_id_check1,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_mon_loc_id_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_mon_loc_id_check1,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_parameter_cd_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_parameter_cd_check1,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_rpt_period_id_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_rpt_period_id_check1;

DROP INDEX IF EXISTS camdecmps.hrly_param_fuel_flow_idx001;
DROP INDEX IF EXISTS camdecmps.hrly_param_fuel_flow_idx002;
DROP INDEX IF EXISTS camdecmps.idx_hpff_add_date;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_hrly_fuel;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_mon_form_i;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_operating;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_parameter;

-- camdecmpswks.hrly_param_fuel_flow
ALTER TABLE IF EXISTS camdecmpswks.hrly_param_fuel_flow
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_hrly_fuel_flow_id_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_hrly_fuel_flow_id_check1,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_hrly_param_ff_id_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_hrly_param_ff_id_check1,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_mon_loc_id_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_mon_loc_id_check1,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_parameter_cd_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_parameter_cd_check1,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_rpt_period_id_check,
	DROP CONSTRAINT IF EXISTS hrly_param_fuel_flow_rpt_period_id_check1;

DROP INDEX IF EXISTS camdecmpswks.hrly_param_fuel_flow_idx001;
DROP INDEX IF EXISTS camdecmpswks.hrly_param_fuel_flow_idx002;
DROP INDEX IF EXISTS camdecmpswks.idx_hpff_add_date;
DROP INDEX IF EXISTS camdecmpswks.idx_hrly_param_fuel_hrly_fuel;
DROP INDEX IF EXISTS camdecmpswks.idx_hrly_param_fuel_mon_form_i;
DROP INDEX IF EXISTS camdecmpswks.idx_hrly_param_fuel_mon_sys_id;
DROP INDEX IF EXISTS camdecmpswks.idx_hrly_param_fuel_operating;
DROP INDEX IF EXISTS camdecmpswks.idx_hrly_param_fuel_parameter;
