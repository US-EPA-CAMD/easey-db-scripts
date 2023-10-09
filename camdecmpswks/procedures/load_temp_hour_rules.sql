-- PROCEDURE: camdecmpswks.load_temp_hour_rules(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.load_temp_hour_rules(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.load_temp_hour_rules(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.tables 
    WHERE table_type = 'LOCAL TEMPORARY'
    AND table_name = 'temp_hour_rules'
  ) THEN

    CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

    CREATE TEMP TABLE temp_hour_rules(
        HOUR_ID character varying(45) NOT NULL,
      CONSTRAINT pk_temp_hour_rules PRIMARY KEY (HOUR_ID)
    );

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
  END IF;
END
$BODY$;
