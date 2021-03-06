-- FUNCTION: camdecmpswks.derived_monitor_plan_status()

-- DROP FUNCTION camdecmpswks.derived_monitor_plan_status();

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
					rpBegin.QUARTER_BEGIN_DATE as BEGIN_DATE,
					rpEnd.QUARTER_END_DATE as END_DATE,
					CASE 
						WHEN NOW() < rpBegin.QUARTER_BEGIN_DATE
						THEN 'FUTURE'
						WHEN END_RPT_PERIOD_ID IS NOT NULL AND NOW() > camdecmpswks.Date_Add('quarter', 1, rpEnd.QUARTER_END_DATE)
						THEN 'RETIRED'
						WHEN END_RPT_PERIOD_ID IS NOT NULL AND NOW() > rpEnd.QUARTER_END_DATE 
						THEN 'RETIRNG'
						ELSE 'ACTIVE'
				   END AS MON_PLAN_STATUS_CD
			FROM camdecmpswks.MONITOR_PLAN mp
				LEFT OUTER JOIN camdecmpswks.vw_reporting_period rpBegin on rpBegin.RPT_PERIOD_ID = mp.BEGIN_RPT_PERIOD_ID
				LEFT OUTER JOIN camdecmpswks.vw_reporting_period rpEnd on rpEnd.RPT_PERIOD_ID = mp.END_RPT_PERIOD_ID
		) as mp
			LEFT OUTER JOIN camdecmpsmd.MONITORING_PLAN_STATUS_CODE mpsc on mpsc.MON_PLAN_STATUS_CD = mp.MON_PLAN_STATUS_CD
$BODY$;
