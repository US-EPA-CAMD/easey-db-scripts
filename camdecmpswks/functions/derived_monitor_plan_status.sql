-- FUNCTION: camdecmpswks.derived_monitor_plan_status()

DROP FUNCTION IF EXISTS camdecmpswks.derived_monitor_plan_status() CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.derived_monitor_plan_status(
	)
    RETURNS TABLE(mon_plan_id text, begin_date date, end_date date, mon_plan_status_cd text, mon_plan_status_cd_description text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT mp.*, MON_PLAN_STATUS_CD_DESCRIPTION
	FROM (
			SELECT	mp.MON_PLAN_ID,
					rpBegin.BEGIN_DATE as BEGIN_DATE,
					rpEnd.END_DATE as END_DATE,
					CASE 
						WHEN NOW() < rpBegin.BEGIN_DATE
						THEN 'FUTURE'
						WHEN END_RPT_PERIOD_ID IS NOT NULL AND NOW() > camdecmpswks.Date_Add('quarter', 1, rpEnd.END_DATE)
						THEN 'RETIRED'
						WHEN END_RPT_PERIOD_ID IS NOT NULL AND NOW() > rpEnd.END_DATE 
						THEN 'RETIRNG'
						ELSE 'ACTIVE'
				   END AS MON_PLAN_STATUS_CD
			FROM camdecmpswks.MONITOR_PLAN mp
				LEFT OUTER JOIN camdecmpsmd.reporting_period rpBegin on rpBegin.RPT_PERIOD_ID = mp.BEGIN_RPT_PERIOD_ID
				LEFT OUTER JOIN camdecmpsmd.reporting_period rpEnd on rpEnd.RPT_PERIOD_ID = mp.END_RPT_PERIOD_ID
		) as mp
			LEFT OUTER JOIN camdecmpsmd.MONITORING_PLAN_STATUS_CODE mpsc on mpsc.MON_PLAN_STATUS_CD = mp.MON_PLAN_STATUS_CD
$BODY$;
