-- FUNCTION: camdecmps.rpt_mp_reporting_frequency(character varying)

DROP FUNCTION IF EXISTS camdecmps.rpt_mp_reporting_frequency(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_mp_reporting_frequency(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "reportFrequency" text, "beginQuarter" text, "endQuarter" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		CASE
			WHEN ml.unit_id IS NULL THEN sp.stack_name
			ELSE u.unitid
		END AS "unitStack",
	    rfc.report_freq_cd || ' - ' || rfc.report_freq_cd_description AS "reportFrequency",
		brp.period_description AS "beginQuarter",
		erp.period_description AS "endQuarter"
	FROM camdecmps.monitor_plan_reporting_freq mprf
	JOIN camdecmps.monitor_plan_location mpl USING(mon_plan_id)
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmpsmd.report_freq_code rfc USING(report_freq_cd)
	LEFT JOIN camdecmpsmd.reporting_period brp ON mprf.begin_rpt_period_id = brp.rpt_period_id
	LEFT JOIN camdecmpsmd.reporting_period erp ON mprf.end_rpt_period_id = erp.rpt_period_id
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
    LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name;
$BODY$;
