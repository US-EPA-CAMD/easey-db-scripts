-- PROCEDURE: camdecmpswks.load_temp_weekly_test_errors(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.load_temp_weekly_test_errors(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.load_temp_weekly_test_errors(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.tables 
    WHERE table_type = 'LOCAL TEMPORARY'
    AND table_name = 'temp_weekly_test_errors'
  ) THEN

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

    INSERT INTO temp_weekly_test_errors(
        WEEKLY_TEST_SUM_ID, 
        MON_PLAN_ID, 
        MON_LOC_ID, 
        RPT_PERIOD_ID, 
        MON_SYS_ID,
        COMPONENT_ID, 
        COMPONENT_IDENTIFIER,
        COMPONENT_TYPE_CD,
        SYSTEM_COMPONENT_IDENTIFIER,
        SYSTEM_COMPONENT_TYPE,
        SPAN_SCALE_CD, 
        TEST_DATE, 
        TEST_TIME, 
        TEST_TYPE_CD, 
        TEST_RESULT_CD, 
        CALC_TEST_RESULT_CD,
        ERROR_CODES
      )
      SELECT	DISTINCT 
          wts.WEEKLY_TEST_SUM_ID, 
          mpl.MON_PLAN_ID,
          mpl.MON_LOC_ID,
          wts.RPT_PERIOD_ID, 
          wts.MON_SYS_ID,
          wts.COMPONENT_ID,
          cmp.COMPONENT_IDENTIFIER, 
          cmp.COMPONENT_TYPE_CD,
          Coalesce(ms.SYSTEM_IDENTIFIER,cmp.COMPONENT_IDENTIFIER) as SYSTEM_COMPONENT_IDENTIFIER,
          Coalesce(ms.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD) as SYSTEM_COMPONENT_TYPE,
          wts.SPAN_SCALE_CD, 
          wts.TEST_DATE, 
          camdecmpswks.format_time(TEST_HOUR, TEST_MIN) as TEST_TIME,
          wts.TEST_TYPE_CD, 
          wts.TEST_RESULT_CD, 
          wts.CALC_TEST_RESULT_CD, 
          CASE WHEN MAX(Coalesce(sev.SEVERITY_LEVEL, 0)) > 0 THEN 'Y' ELSE NULL END AS ERROR_CODES
      FROM (
        SELECT MON_PLAN_ID, MON_LOC_ID
        FROM camdecmpswks.MONITOR_PLAN_LOCATION
        WHERE MON_PLAN_ID = vmonplanid
      ) mpl
      JOIN camdecmpswks.EMISSION_EVALUATION evl
        ON evl.MON_PLAN_ID = mpl.MON_PLAN_ID
        AND evl.RPT_PERIOD_ID = vRptPeriodId
      JOIN camdecmpswks.WEEKLY_TEST_SUMMARY wts
        ON wts.MON_LOC_ID = mpl.MON_LOC_ID
        AND wts.RPT_PERIOD_ID = vRptPeriodId
      LEFT JOIN camdecmpswks.MONITOR_SYSTEM AS ms
        ON ms.MON_SYS_ID = wts.MON_SYS_ID
      LEFT JOIN camdecmpswks.COMPONENT AS cmp
        ON cmp.COMPONENT_ID = wts.COMPONENT_ID
      LEFT JOIN camdecmpswks.CHECK_LOG log
        ON log.CHK_SESSION_ID = evl.CHK_SESSION_ID
        AND log.TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
      LEFT JOIN camdecmpsmd.SEVERITY_CODE sev
        ON sev.SEVERITY_CD = log.SEVERITY_CD
      GROUP BY
          wts.WEEKLY_TEST_SUM_ID, 
          mpl.MON_PLAN_ID,
          mpl.MON_LOC_ID,
          wts.RPT_PERIOD_ID, 
          wts.MON_SYS_ID,
          wts.COMPONENT_ID,
          cmp.COMPONENT_IDENTIFIER, 
          cmp.COMPONENT_TYPE_CD,
          Coalesce(ms.SYSTEM_IDENTIFIER,cmp.COMPONENT_IDENTIFIER),
          Coalesce(ms.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD),
          wts.SPAN_SCALE_CD, 
          wts.TEST_DATE, 
          camdecmpswks.format_time(TEST_HOUR, TEST_MIN),
          wts.TEST_TYPE_CD, 
          wts.TEST_RESULT_CD, 
          wts.CALC_TEST_RESULT_CD;
	END IF;
END
$BODY$;
