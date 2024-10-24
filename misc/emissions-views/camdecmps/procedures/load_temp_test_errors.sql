-- PROCEDURE: camdecmps.load_temp_test_errors()

DROP PROCEDURE IF EXISTS camdecmps.load_temp_test_errors();

CREATE OR REPLACE PROCEDURE camdecmps.load_temp_test_errors()
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	dataset record;
	sqlStatement text;
BEGIN
	-- DROP TEMP TABLES
	DROP TABLE IF EXISTS temp_hour_rules;
	DROP TABLE IF EXISTS temp_hourly_test_errors;
	DROP TABLE IF EXISTS temp_daily_test_errors;
	DROP TABLE IF EXISTS temp_weekly_test_errors;

	-- CREATE TEMP TABLES USED TO REFRESH EMISSIONS DATA VIEWS
	CREATE TEMP TABLE temp_hour_rules(
    	HOUR_ID character varying(45) NOT NULL,
		CONSTRAINT pk_temp_hour_rules PRIMARY KEY (HOUR_ID)
	);

	CREATE TEMP TABLE temp_hourly_test_errors(
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
		ERROR_CODES character varying(1),
		CONSTRAINT pk_temp_hourly_test_errors PRIMARY KEY (HOUR_ID)
	);

  CREATE INDEX IF NOT EXISTS idx_temp_hourly_test_errors_mon_plan_id
    ON temp_hourly_test_errors USING btree
    (MON_PLAN_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_hourly_test_errors_mon_loc_id
    ON temp_hourly_test_errors USING btree
    (MON_LOC_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_hourly_test_errors_rpt_period_id
    ON temp_hourly_test_errors USING btree
    (RPT_PERIOD_ID ASC NULLS LAST);


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
		ERROR_CODES character varying(1),
		CONSTRAINT pk_temp_daily_test_errors PRIMARY KEY (DAILY_TEST_SUM_ID)
	);

  CREATE INDEX IF NOT EXISTS idx_temp_daily_test_errors_mon_plan_id
    ON temp_daily_test_errors USING btree
    (MON_PLAN_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_daily_test_errors_mon_loc_id
    ON temp_daily_test_errors USING btree
    (MON_LOC_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_daily_test_errors_component_id
    ON temp_daily_test_errors USING btree
    (COMPONENT_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_daily_test_errors_rpt_period_id
    ON temp_daily_test_errors USING btree
    (RPT_PERIOD_ID ASC NULLS LAST);


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
		ERROR_CODES character varying(1),
		CONSTRAINT pk_temp_weekly_test_errors PRIMARY KEY (WEEKLY_TEST_SUM_ID)
	);

  CREATE INDEX IF NOT EXISTS idx_temp_weekly_test_errors_mon_plan_id
    ON temp_weekly_test_errors USING btree
    (MON_PLAN_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_weekly_test_errors_mon_loc_id
    ON temp_weekly_test_errors USING btree
    (MON_LOC_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_weekly_test_errors_mon_sys_id
    ON temp_weekly_test_errors USING btree
    (MON_SYS_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_weekly_test_errors_component_id
    ON temp_weekly_test_errors USING btree
    (COMPONENT_ID COLLATE pg_catalog."default" ASC NULLS LAST);

  CREATE INDEX IF NOT EXISTS idx_temp_weekly_test_errors_rpt_period_id
    ON temp_weekly_test_errors USING btree
    (RPT_PERIOD_ID ASC NULLS LAST);


	-- LOAD TEMP TABLES WITH EVALUATION ERROR DATA
	CALL camdecmps.load_temp_hourly_test_errors();
	CALL camdecmps.load_temp_daily_test_errors();
	CALL camdecmps.load_temp_weekly_test_errors();
END;
$BODY$;
