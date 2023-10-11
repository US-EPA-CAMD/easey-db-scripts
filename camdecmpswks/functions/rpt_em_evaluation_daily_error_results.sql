-- FUNCTION: camdecmpswks.rpt_em_evaluation_daily_error_results(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_evaluation_daily_error_results(text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_evaluation_daily_error_results(
	vmonplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE("unitStack" text, "severityCode" text, "categoryDescription" text, "checkCode" text, "resultMessage" text, "beginPeriod" text, "endPeriod" text, "consecutiveHours" numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT DISTINCT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
    cl.severity_cd AS "severityCode",
  	LTRIM(TRIM(leading '-' from ccd.category_cd_description)) AS "categoryDescription",
  	cc.check_type_cd || '-' || cc.check_number || '-' || ccr.check_result AS "checkCode",
	  cl.result_message AS "resultMessage",
		camdecmpswks.format_date_hour(cl.op_begin_date, cl.op_begin_hour, null) AS "beginPeriod",
		camdecmpswks.format_date_hour(cl.op_end_date, cl.op_end_hour, null) AS "endPeriod",
		EXTRACT(HOUR FROM (cl.op_end_date + cl.op_end_hour * interval '1 hour') - (cl.op_begin_date + cl.op_begin_hour * interval '1 hour'))::numeric AS "consecutiveHours"
	FROM camdecmpswks.check_log cl
	JOIN camdecmpswks.check_session cs USING(chk_session_id)
	JOIN camdecmpsmd.reporting_period rp USING(rpt_period_id)
	JOIN camdecmpsmd.check_catalog_result ccr USING(check_catalog_result_id)
	JOIN camdecmpsmd.check_catalog cc ON ccr.check_catalog_id = cc.check_catalog_id
	JOIN camdecmpsmd.rule_check rc ON cl.rule_check_id = rc.rule_check_id
	JOIN camdecmpsmd.category_code ccd ON rc.category_cd = ccd.category_cd
	LEFT JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE cs.mon_plan_id = vMonPlanId AND rp.calendar_year = vYear AND rp.quarter = vQuarter AND
	ccd.process_cd = 'HOURLY' AND cc.check_type_cd = 'DAILY';
$BODY$;
