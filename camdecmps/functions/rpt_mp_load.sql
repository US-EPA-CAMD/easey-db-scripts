-- FUNCTION: camdecmps.rpt_mp_load(character varying)

DROP FUNCTION IF EXISTS camdecmps.rpt_mp_load(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_mp_load(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "maxLoadValue" numeric, "unitsOfMeasureCode" text, "unitsOfMeasureCodeGroup" text, "unitsOfMeasureCodeDescription" text, "upperOperatingBoundry" numeric, "lowerOperatingBoundry" numeric, "normalOperatingLevel" text, "secondOperatingLevel" text, "secondNormalIndicator" text, "loadAnalysisDate" text, "beginDateHour" text, "endDateHour" text) 
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
		l.max_load_value AS "maxLoadValue",
		l.max_load_uom_cd AS "unitsOfMeasureCode",
		'Units of Measure' AS "unitsOfMeasureCodeGroup",
		uom.uom_cd_description AS "unitsOfMeasureCodeDescription",
		l.up_op_boundary AS "upperOperatingBoundry",
		l.low_op_boundary AS "lowerOperatingBoundry",
		nlc.op_level_cd_description AS "normalOperatingLevel",
		slc.op_level_cd_description AS "secondOperatingLevel",
		camdecmps.format_indicator(l.second_normal_ind, true) AS "secondNormalIndicator",
		camdecmps.format_date_hour(l.load_analysis_date, null, null) AS "loadAnalysisDate",
		camdecmps.format_date_hour(l.begin_date, l.begin_hour, null) AS "beginDateHour",
		camdecmps.format_date_hour(l.end_date, l.end_hour, null) AS "endDateHour"
	FROM camdecmps.monitor_load l
	JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmpsmd.units_of_measure_code uom ON l.max_load_uom_cd = uom.uom_cd
	LEFT JOIN camdecmpsmd.operating_level_code nlc ON l.normal_level_cd = nlc.op_level_cd
	LEFT JOIN camdecmpsmd.operating_level_code slc ON l.second_level_cd = slc.op_level_cd	
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
  	LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, l.begin_date, l.begin_hour;
$BODY$;
