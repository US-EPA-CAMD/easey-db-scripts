-- FUNCTION: camdecmps.rpt_mp_method(character varying)

DROP FUNCTION IF EXISTS camdecmps.rpt_mp_method(character varying);

CREATE OR REPLACE FUNCTION camdecmps.rpt_mp_method(
	monplanid character varying
)
RETURNS TABLE(
	"unitStack" text, 
	"parameterCode" text, 
  "parameterCodeGroup" text, 
  "parameterCodeDescription" text, 
  "methodCode" text,
  "methodCodeGroup" text,
  "methodCodeDescription" text,
  "substituteDataCode" text,
  "substituteDataCodeGroup" text,
  "substituteDataCodeDescription" text,
  "bypassApproachCode" text,
  "bypassApproachCodeGroup" text,
  "bypassApproachCodeDescription" text,
  "beginDateHour" text,
  "endDateHour" text
)
LANGUAGE 'sql'
AS $BODY$
	SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		mm.parameter_cd AS "parameterCode",
		'Parameter Codes' AS "parameterCodeGroup",		
		pc.parameter_cd_description AS "parameterCodeDescription",
		mm.method_cd AS "methodCode",
		'Methodology Codes' AS "methodCodeGroup",
		mc.method_cd_description AS "methodCodeDescription",
		mm.sub_data_cd AS "substituteDataCode",
		'Substitute Data Codes' AS "substituteDataCodeGroup",
		sdc.sub_data_cd_description AS "substituteDataCodeDescription",
		mm.bypass_approach_cd AS "bypassApproachCode",
		'Bypass Approach Codes' AS "bypassApproachCodeGroup",
		bac.bypass_approach_cd_description AS "bypassApproachCodeDescription",
		camdecmps.format_date_hour(mm.begin_date, mm.begin_hour, null) AS "beginDateHour",
		camdecmps.format_date_hour(mm.end_date, mm.end_hour, null) AS "endDateHour"
	FROM camdecmps.monitor_method mm
	JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	JOIN camdecmpsmd.parameter_code pc USING(parameter_cd)
	JOIN camdecmpsmd.method_code mc USING(method_cd)
	LEFT JOIN camdecmpsmd.substitute_data_code sdc USING(sub_data_cd)
	LEFT JOIN camdecmpsmd.bypass_approach_code bac USING(bypass_approach_cd)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
    LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, mm.parameter_cd, mm.method_cd, mm.begin_date, mm.begin_hour;
$BODY$;
