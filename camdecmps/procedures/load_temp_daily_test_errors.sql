-- PROCEDURE: camdecmps.load_temp_daily_test_errors(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmps.load_temp_daily_test_errors(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.load_temp_daily_test_errors(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.tables 
    WHERE table_type = 'LOCAL TEMPORARY'
    AND table_name = 'temp_daily_test_errors'
  ) THEN

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

    INSERT INTO temp_daily_test_errors(
      DAILY_TEST_SUM_ID,
      MON_PLAN_ID, 
      MON_LOC_ID, 
      RPT_PERIOD_ID, 
      COMPONENT_ID, 
      COMPONENT_IDENTIFIER,
      COMPONENT_TYPE_CD,
      SYSTEM_COMPONENT_IDENTIFIER,
      SYSTEM_COMPONENT_TYPE,
      SPAN_SCALE_CD, 
      END_DATE, 
      END_TIME, 
      TEST_TYPE_CD, 
      TEST_RESULT_CD, 
      CALC_TEST_RESULT_CD,
      ERROR_CODES
    )
    SELECT DISTINCT 
      dts.DAILY_TEST_SUM_ID, 
      mpl.MON_PLAN_ID, 
      mpl.MON_LOC_ID, 
      dts.RPT_PERIOD_ID, 
      dts.COMPONENT_ID,
      cmp.COMPONENT_IDENTIFIER,
      cmp.COMPONENT_TYPE_CD,
      Coalesce(ms.SYSTEM_IDENTIFIER, cmp.COMPONENT_IDENTIFIER) AS SYSTEM_COMPONENT_IDENTIFIER,
      Coalesce(ms.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD) AS SYSTEM_COMPONENT_TYPE,
      dts.SPAN_SCALE_CD, 
      dts.DAILY_TEST_DATE AS END_DATE, 
      camdecmps.format_time( dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN ) AS END_TIME,
      dts.TEST_TYPE_CD, 
      dts.TEST_RESULT_CD, 
      dts.CALC_TEST_RESULT_CD,
      CASE WHEN MAX(Coalesce(sev.SEVERITY_LEVEL, 0)) > 0 THEN 'Y' ELSE NULL END AS ERROR_CODES
    FROM (
      SELECT MON_PLAN_ID, MON_LOC_ID
      FROM camdecmps.MONITOR_PLAN_LOCATION
      WHERE MON_PLAN_ID = vmonplanid
    ) mpl
    JOIN camdecmps.EMISSION_EVALUATION evl
      ON evl.MON_PLAN_ID = mpl.MON_PLAN_ID
      AND evl.RPT_PERIOD_ID = vRptPeriodId
    JOIN camdecmps.DAILY_TEST_SUMMARY dts
      ON dts.MON_LOC_ID = mpl.MON_LOC_ID
      AND dts.RPT_PERIOD_ID = vRptPeriodId
    LEFT JOIN camdecmps.MONITOR_SYSTEM AS ms
      ON ms.MON_SYS_ID = dts.MON_SYS_ID
    LEFT JOIN camdecmps.COMPONENT AS cmp
      ON cmp.COMPONENT_ID = dts.COMPONENT_ID
    LEFT JOIN camdecmpsaux.CHECK_LOG AS cl
      ON cl.CHK_SESSION_ID = evl.CHK_SESSION_ID
      AND cl.TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
    LEFT JOIN camdecmpsmd.SEVERITY_CODE AS sev
      ON sev.SEVERITY_CD = cl.SEVERITY_CD
    GROUP BY	dts.DAILY_TEST_SUM_ID, 
          mpl.MON_PLAN_ID, 
          mpl.MON_LOC_ID, 
          dts.RPT_PERIOD_ID, 
          dts.COMPONENT_ID,
          cmp.COMPONENT_IDENTIFIER, 
          cmp.COMPONENT_TYPE_CD,
          Coalesce(ms.SYSTEM_IDENTIFIER, cmp.COMPONENT_IDENTIFIER),
          Coalesce(ms.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD),
          dts.SPAN_SCALE_CD, 
          dts.DAILY_TEST_DATE, 
          camdecmps.format_time( dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN ),
          dts.TEST_TYPE_CD, 
          dts.TEST_RESULT_CD, 
          dts.CALC_TEST_RESULT_CD;
  END IF;
END
$BODY$;
