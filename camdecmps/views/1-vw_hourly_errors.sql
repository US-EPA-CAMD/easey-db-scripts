-- View: camdecmps.vw_hourly_errors

DROP VIEW IF EXISTS camdecmps.vw_hourly_errors CASCADE;

CREATE OR REPLACE VIEW camdecmps.vw_hourly_errors
AS
	SELECT DISTINCT hod.hour_id,
		mpl.mon_plan_id,
		mpl.mon_loc_id,
		hod.rpt_period_id,
		hod.begin_date,
		hod.begin_hour,
		hod.op_time,
		hod.hr_load,
		hod.mats_load,
		hod.load_uom_cd,
		hod.load_range,
		hod.common_stack_load_range,
		hod.fc_factor,
		hod.fd_factor,
		hod.fw_factor,
		hod.fuel_cd,
		CASE
			WHEN hod.mats_startup_shutdown_flg::text = 'U'::text THEN 'Startup'::character varying
			WHEN hod.mats_startup_shutdown_flg::text = 'D'::text THEN 'Shutdown'::character varying
			ELSE hod.mats_startup_shutdown_flg
		END AS mats_startup_shutdown,
		CASE
			WHEN max(COALESCE(sev.severity_level, 0::numeric)) > 0::numeric THEN 'View Errors'::text
			ELSE NULL::text
		END AS error_codes
	FROM camdecmps.monitor_plan_location mpl
	JOIN camdecmps.hrly_op_data hod ON hod.mon_loc_id::text = mpl.mon_loc_id::text
	LEFT JOIN camdecmps.emission_evaluation evl ON evl.mon_plan_id::text = mpl.mon_plan_id::text AND evl.rpt_period_id = hod.rpt_period_id
	LEFT JOIN camdecmpsaux.check_log log ON log.chk_session_id::text = evl.chk_session_id::text AND log.mon_loc_id::text = mpl.mon_loc_id::text AND (log.op_begin_date < hod.begin_date OR log.op_begin_date = hod.begin_date AND log.op_begin_hour <= hod.begin_hour) AND (log.op_end_date > hod.begin_date OR log.op_end_date = hod.begin_date AND log.op_end_hour >= hod.begin_hour)
	LEFT JOIN camdecmpsmd.severity_code sev ON sev.severity_cd::text = log.severity_cd::text
	GROUP BY hod.hour_id, mpl.mon_plan_id, mpl.mon_loc_id, hod.rpt_period_id, hod.begin_date, hod.begin_hour, hod.op_time, hod.hr_load, hod.mats_load, hod.load_uom_cd, hod.load_range, hod.common_stack_load_range, hod.fc_factor, hod.fd_factor, hod.fw_factor, hod.fuel_cd, hod.mats_startup_shutdown_flg;
