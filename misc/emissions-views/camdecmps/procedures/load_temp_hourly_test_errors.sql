-- PROCEDURE: camdecmps.load_temp_hourly_test_errors()

DROP PROCEDURE IF EXISTS camdecmps.load_temp_hourly_test_errors();

CREATE OR REPLACE PROCEDURE camdecmps.load_temp_hourly_test_errors()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';

	INSERT INTO temp_hourly_test_errors(
		HOUR_ID, 
		MON_PLAN_ID, 
		MON_LOC_ID, 
		RPT_PERIOD_ID, 
		BEGIN_DATE, 
		BEGIN_HOUR, 
		OP_TIME, 
		HR_LOAD, 
		MATS_LOAD,
		LOAD_UOM_CD,
		LOAD_RANGE,
		COMMON_STACK_LOAD_RANGE,
		FC_FACTOR, 
		FD_FACTOR, 
		FW_FACTOR,
		FUEL_CD,
		MATS_STARTUP_SHUTDOWN,
		ERROR_CODES
	)
	SELECT DISTINCT
		hod.hour_id,
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
	JOIN camdecmps.hrly_op_data hod
		ON hod.mon_loc_id::text = mpl.mon_loc_id::text
	JOIN camdecmps.emission_evaluation evl
		ON evl.mon_plan_id::text = mpl.mon_plan_id::text
		AND evl.rpt_period_id = hod.rpt_period_id
	LEFT JOIN camdecmpsaux.check_log log
		ON log.chk_session_id::text = evl.chk_session_id::text AND
		log.mon_loc_id::text = mpl.mon_loc_id::text AND (
			log.op_begin_date < hod.begin_date OR (
				log.op_begin_date = hod.begin_date AND
				log.op_begin_hour <= hod.begin_hour
			)
		) AND (
			log.op_end_date > hod.begin_date OR (
				log.op_end_date = hod.begin_date AND
				log.op_end_hour >= hod.begin_hour
			)
		)
	LEFT JOIN camdecmpsmd.severity_code sev
		ON sev.severity_cd::text = log.severity_cd::text
	GROUP BY
		hod.hour_id,
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
		hod.mats_startup_shutdown_flg;

  RAISE NOTICE 'Loading temp_hour_rules...';

	INSERT INTO temp_hour_rules(HOUR_ID)
	SELECT DISTINCT ge.hour_id
	FROM temp_hourly_test_errors ge
	JOIN camdecmps.emission_evaluation evl
		ON evl.mon_plan_id::text = ge.mon_plan_id::text
		AND evl.rpt_period_id = ge.rpt_period_id
	JOIN camdecmps.hrly_op_data hod
		ON hod.hour_id::text = ge.hour_id::text
	JOIN camdecmpsaux.check_log log
		ON log.chk_session_id::text = evl.chk_session_id::text AND
		log.mon_loc_id::text = ge.mon_loc_id::text AND (
			log.op_begin_date < hod.begin_date OR (
				log.op_begin_date = hod.begin_date AND
				log.op_begin_hour <= hod.begin_hour
			)
		) AND (
			log.op_end_date > hod.begin_date OR (
				log.op_end_date = hod.begin_date AND
				log.op_end_hour >= hod.begin_hour
			)
		)
	JOIN camdecmpsmd.rule_check rc
		ON rc.rule_check_id = log.rule_check_id
		AND "substring"(COALESCE(rc.category_cd, ''::character varying)::text, 1, 2) = 'ST'::text;
END
$BODY$;
