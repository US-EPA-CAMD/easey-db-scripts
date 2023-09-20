-- FUNCTION: camdecmps.rpt_mp_analyzer_range(character varying)

DROP FUNCTION IF EXISTS camdecmps.rpt_mp_analyzer_range(character varying);

CREATE OR REPLACE FUNCTION camdecmps.rpt_mp_analyzer_range(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "componentTypeCode" text, "componentTypeCodeGroup" text, "componentTypeCodeDescription" text, "componentIdentifier" text, "analyzerRangeLevel" text, "dualRangeIndicator" text, "beginDateHour" text, "endDateHour" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		c.component_type_cd AS "componentTypeCode",
		'Component Type Codes' AS "componentTypeCodeGroup",
		ctc.component_type_cd_description AS "componentTypeCodeDescription",
		c.component_identifier AS "componentIdentifier",
		arc.analyzer_range_cd_description AS "analyzerRangeLevel",
		camdecmps.format_indicator(ar.dual_range_ind, true) AS "dualRangeIndicator",
		camdecmps.format_date_hour(ar.begin_date, ar.begin_hour, null) AS "beginDateHour",
		camdecmps.format_date_hour(ar.end_date, ar.end_hour, null) AS "endDateHour"
	FROM camdecmps.analyzer_range ar
	JOIN camdecmps.component c USING(component_id)
	JOIN camdecmps.monitor_plan_location mpl ON c.mon_loc_id = mpl.mon_loc_id
	JOIN camdecmps.monitor_location ml ON mpl.mon_loc_id = ml.mon_loc_id
	JOIN camdecmpsmd.component_type_code ctc USING(component_type_cd)
	JOIN camdecmpsmd.analyzer_range_code arc USING(analyzer_range_cd)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
  	LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, c.component_type_cd, ar.begin_date, ar.begin_hour;
$BODY$;
