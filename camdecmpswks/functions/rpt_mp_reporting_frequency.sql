-- FUNCTION: camdecmpswks.rpt_mp_reporting_frequency(character varying)

-- DROP FUNCTION camdecmpswks.rpt_mp_reporting_frequency(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_reporting_frequency(
	monplanid character varying)
    RETURNS TABLE("unitStack" character varying, frequency character varying, "beginQuarter" character varying, "endQuarter" text) 
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
	    rfc.report_freq_cd || ' - ' || rfc.report_freq_cd_description AS "frequency",
		brp.calendar_year || ' QTR ' || brp.quarter AS "beginQuarter",
		erp.calendar_year || ' QTR ' || erp.quarter AS "endQuarter"
	FROM camdecmpswks.monitor_plan_reporting_freq mprf
	 JOIN camdecmpsmd.report_freq_code rfc USING(report_freq_cd)
	 JOIN camdecmpswks.monitor_plan_location mpl USING(mon_plan_id)
	 JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	 LEFT JOIN camdecmpsmd.reporting_period brp ON mprf.begin_rpt_period_id = brp.rpt_period_id
	 LEFT JOIN camdecmpsmd.reporting_period erp ON mprf.end_rpt_period_id = erp.rpt_period_id
	 LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
     LEFT JOIN camd.unit u USING(unit_id)
	WHERE mprf.mon_plan_id = monPlanId;
$BODY$;
