-- PROCEDURE: camdecmpswks.load_temp_hourly_test_errors(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.load_temp_hourly_test_errors(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.load_temp_hourly_test_errors(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.tables 
    WHERE table_type = 'LOCAL TEMPORARY'
    AND table_name = 'temp_hourly_test_errors'
  ) THEN

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
      CASE WHEN MAX(Coalesce(sev.SEVERITY_LEVEL, 0)) > 0 THEN 'Y' ELSE NULL END AS ERROR_CODES
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
	END IF;
END
$BODY$;
