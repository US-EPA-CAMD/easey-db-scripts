-- PROCEDURE: camdecmpswks.load_temp_hourly_test_errors(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.load_temp_hourly_test_errors(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.load_temp_hourly_test_errors(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
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
		hod.HOUR_ID, 
		mpl.MON_PLAN_ID, 
		mpl.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		hod.BEGIN_DATE, 
		hod.BEGIN_HOUR, 
		hod.OP_TIME, 
		hod.HR_LOAD,
		hod.MATS_LOAD,
		hod.LOAD_UOM_CD, 
		hod.LOAD_RANGE,
		hod.COMMON_STACK_LOAD_RANGE,
		hod.FC_FACTOR, 
		hod.FD_FACTOR, 
		hod.FW_FACTOR,
		hod.FUEL_CD,
		CASE
			WHEN hod.MATS_STARTUP_SHUTDOWN_FLG = 'U' THEN 'Startup'
			WHEN hod.MATS_STARTUP_SHUTDOWN_FLG = 'D' THEN 'Shutdown'
			ELSE hod.MATS_STARTUP_SHUTDOWN_FLG
		END, 
		CASE
			WHEN MAX(Coalesce(sev.SEVERITY_LEVEL, 0)) > 0 THEN 'View Errors'
			ELSE NULL
		END AS ERROR_CODES
	FROM (
		SELECT MON_PLAN_ID, MON_LOC_ID
		FROM camdecmpswks.MONITOR_PLAN_LOCATION
		WHERE MON_PLAN_ID = vmonplanid
	) mpl
	JOIN camdecmpswks.EMISSION_EVALUATION evl
		ON evl.MON_PLAN_ID = mpl.MON_PLAN_ID
		AND evl.RPT_PERIOD_ID = vrptperiodid
	JOIN camdecmpswks.HRLY_OP_DATA hod
		ON hod.MON_LOC_ID = mpl.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = vrptperiodid
	LEFT JOIN camdecmpswks.CHECK_LOG log
		ON log.CHK_SESSION_ID = evl.CHK_SESSION_ID AND
		log.MON_LOC_ID = mpl.MON_LOC_ID AND (
			log.OP_BEGIN_DATE < hod.BEGIN_DATE OR (
				log.OP_BEGIN_DATE = hod.BEGIN_DATE AND
				log.OP_BEGIN_HOUR <= hod.BEGIN_HOUR
			)
		) AND (
			log.OP_END_DATE > hod.BEGIN_DATE OR (
				log.OP_END_DATE = hod.BEGIN_DATE AND
				log.OP_END_HOUR >= hod.BEGIN_HOUR
			)
		)
	LEFT JOIN camdecmpsmd.SEVERITY_CODE sev
		ON sev.SEVERITY_CD = log.SEVERITY_CD
	GROUP BY
		hod.HOUR_ID, 
		mpl.MON_PLAN_ID, 
		mpl.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		hod.BEGIN_DATE, 
		hod.BEGIN_HOUR, 
		hod.OP_TIME, 
		hod.HR_LOAD, 
		hod.MATS_LOAD,
		hod.LOAD_UOM_CD, 
		hod.LOAD_RANGE,
		hod.COMMON_STACK_LOAD_RANGE,
		hod.FC_FACTOR, 
		hod.FD_FACTOR, 
		hod.FW_FACTOR,
		hod.FUEL_CD,
		hod.MATS_STARTUP_SHUTDOWN_FLG;

	INSERT INTO temp_hour_rules(HOUR_ID) 
	SELECT DISTINCT ge.HOUR_ID
	FROM temp_hourly_test_errors ge
	INNER JOIN camdecmpswks.EMISSION_EVALUATION evl 
		ON evl.MON_PLAN_ID = ge.MON_PLAN_ID 
		AND evl.RPT_PERIOD_ID = ge.RPT_PERIOD_ID		
	INNER JOIN camdecmpswks.HRLY_OP_DATA hod 
		ON hod.HOUR_ID = ge.HOUR_ID 
	INNER JOIN camdecmpswks.CHECK_LOG log
		ON log.CHK_SESSION_ID = evl.CHK_SESSION_ID AND
		log.MON_LOC_ID = ge.MON_LOC_ID AND (
			log.OP_BEGIN_DATE < hod.BEGIN_DATE OR (
				log.OP_BEGIN_DATE = hod.BEGIN_DATE AND
				log.OP_BEGIN_HOUR <= hod.BEGIN_HOUR
			)
		) AND (
			log.OP_END_DATE > hod.BEGIN_DATE OR (
				log.OP_END_DATE = hod.BEGIN_DATE AND
				log.OP_END_HOUR >= hod.BEGIN_HOUR
			)
		)
	INNER JOIN camdecmpsmd.RULE_CHECK rc
		ON rc.RULE_CHECK_ID = log.RULE_CHECK_ID	
		AND SUBSTRING(Coalesce(rc.CATEGORY_CD, ''), 1, 2) = 'ST';
END
$BODY$;
