-- PROCEDURE: camdecmpswks.refresh_emissions_views(character varying, numeric, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emissions_views(character varying, numeric, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emissions_views(
	vmonplanid character varying,
	vyear numeric,
	vquarter numeric)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	vRptPeriodId numeric(38,0);
	sqlStatement text;
	dataset record;
BEGIN
	SELECT rpt_period_id
	FROM camdecmpsmd.reporting_period
	WHERE calendar_year = vYear AND quarter = vQuarter
	INTO vRptPeriodId;

	RAISE NOTICE 'Refreshing Emissions data views for Monitor Plan [%] and Reportiong Period [Id: %, Yr: %, Qrt: %],', vMonPlanId, vRptPeriodId, vYear, vQuarter;

	-- DROP TEMP TABLES
	DROP TABLE IF EXISTS temp_hourly_errors;
	DROP TABLE IF EXISTS temp_daily_test_errors;
	DROP TABLE IF EXISTS temp_weekly_test_errors;

	-- CREATE TEMP TABLES USED TO REFRESH EMISSIONS DATA VIEWS
	CREATE TEMP TABLE temp_hourly_errors(
		HOUR_ID character varying(45) NOT NULL,
		MON_PLAN_ID character varying(45) NOT NULL, 
		MON_LOC_ID character varying(45) NOT NULL, 
		RPT_PERIOD_ID numeric(38,0) NOT NULL, 
		BEGIN_DATE date NOT NULL, 
		BEGIN_HOUR numeric(2,0) NOT NULL, 
		OP_TIME numeric(3,2), 
		HR_LOAD numeric(6,0), 
		MATS_LOAD numeric(6,0), 
		LOAD_UOM_CD character varying(7), 
		LOAD_RANGE integer,
		COMMON_STACK_LOAD_RANGE integer,
		FC_FACTOR numeric(8,1), 
		FD_FACTOR numeric(8,1), 
		FW_FACTOR numeric(8,1), 
		FUEL_CD character varying(7),
		MATS_STARTUP_SHUTDOWN character varying(100), 
		ERROR_CODES character varying(1000),
		CONSTRAINT pk_temp_hourly_errors PRIMARY KEY (HOUR_ID)
	);

	CREATE TEMP TABLE temp_daily_test_errors(
		DAILY_TEST_SUM_ID character varying(45) NOT NULL,
		MON_PLAN_ID character varying(45) NOT NULL, 
		MON_LOC_ID character varying(45) NOT NULL, 
		RPT_PERIOD_ID numeric(38,0) NOT NULL, 
		COMPONENT_ID character varying(45), 
		COMPONENT_IDENTIFIER character varying(3),
		COMPONENT_TYPE_CD character varying(7),
		SYSTEM_COMPONENT_IDENTIFIER character varying(3),
		SYSTEM_COMPONENT_TYPE character varying(7),
		SPAN_SCALE_CD character varying(7), 
		END_DATE date NOT NULL, 
		END_TIME character varying(5), 
		TEST_TYPE_CD character varying(7), 
		TEST_RESULT_CD character varying(7), 
		CALC_TEST_RESULT_CD character varying(7),
		ERROR_CODES character varying(1000),
		CONSTRAINT pk_temp_daily_test_errors PRIMARY KEY (DAILY_TEST_SUM_ID)
	);

	CREATE TEMP TABLE temp_weekly_test_errors(
		WEEKLY_TEST_SUM_ID character varying(45) NOT NULL, 
		MON_PLAN_ID character varying(45) NOT NULL, 
		MON_LOC_ID character varying(45) NOT NULL, 
		RPT_PERIOD_ID numeric(38,0) NOT NULL, 
		MON_SYS_ID character varying(45), 
		COMPONENT_ID character varying(45), 
		COMPONENT_IDENTIFIER character varying(3),
		COMPONENT_TYPE_CD character varying(7),
		SYSTEM_COMPONENT_IDENTIFIER character varying(3),
		SYSTEM_COMPONENT_TYPE character varying(7),
		SPAN_SCALE_CD character varying(7), 
		TEST_DATE date NOT NULL, 
		TEST_TIME character varying(5), 
		TEST_TYPE_CD character varying(7), 
		TEST_RESULT_CD character varying(7), 
		CALC_TEST_RESULT_CD character varying(7),
		ERROR_CODES character varying(1000),
		CONSTRAINT pk_temp_weekly_test_errors PRIMARY KEY (WEEKLY_TEST_SUM_ID)
	);

	-- LOAD TEMP TABLES WITH EVALUATION ERROR DATA
	CALL camdecmpswks.load_temp_daily_test_errors(vMonPlanId, vRptPeriodId);
	CALL camdecmpswks.load_temp_weekly_test_errors(vMonPlanId, vRptPeriodId);
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

	-- REFRESH EMISSION DATA VIEWS
	FOR dataset IN SELECT * FROM camdaux.dataset WHERE group_cd = 'EMVIEW' AND dataset_cd NOT IN ('LTFF', 'NSPS4T')
	LOOP
		sqlStatement := format('CALL camdecmpswks.refresh_emission_view_%s(%L, %s);', dataset.dataset_cd, vMonPlanId, vRptPeriodId);
		RAISE NOTICE 'Refreshing %...', dataset.display_name;
		RAISE NOTICE '%', sqlStatement;
		EXECUTE sqlStatement;
	END LOOP;
END;
$BODY$;
