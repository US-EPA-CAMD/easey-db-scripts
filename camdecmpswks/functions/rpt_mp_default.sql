-- FUNCTION: camdecmpswks.rpt_mp_default(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_mp_default(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_default(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "parameterCode" text, "parameterCodeGroup" text, "parameterCodeDescription" text, "defaultValue" numeric, "unitsOfMeasureCode" text, "unitsOfMeasureCodeGroup" text, "unitsOfMeasureCodeDescription" text, "defaultPurposeCode" text, "defaultPurposeCodeGroup" text, "defaultPurposeCodeDescription" text, "fuelCode" text, "fuelCodeGroup" text, "fuelCodeDescription" text, "operatingConditionCode" text, "operatingConditionCodeGroup" text, "operatingConditionCodeDescription" text, "defaultSourceCode" text, "defaultSourceCodeGroup" text, "defaultSourceCodeDescription" text, "beginDateHour" text, "endDateHour" text) 
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
		md.parameter_cd AS "parameterCode",
		'Parameter Codes' AS "parameterCodeGroup",
		pc.parameter_cd_description AS "parameterCodeDescription",
		md.default_value AS "defaultValue",
		md.default_uom_cd AS "unitsOfMeasureCode",
		'Units of Measure' AS "unitsOfMeasureCodeGroup",
		uom.uom_cd_description AS "unitsOfMeasureCodeDescription",
		md.default_purpose_cd AS "defaultPurposeCode",
		'Default Purpose Codes' AS "defaultPurposeCodeGroup",
		dpc.def_purpose_cd_description AS "defaultPurposeCodeDescription",
		md.fuel_cd AS "fuelCode",
		'Fuel Codes' AS "fuelCodeGroup",
		fc.fuel_cd_description AS "fuelCodeDescription",
		md.operating_condition_cd AS "operatingConditionCode",
		'Operating Condition Codes' AS "operatingConditionCodeGroup",
		occ.op_condition_cd_description AS "operatingConditionCodeDescription",
		md.default_source_cd AS "defaultSourceCode",
		'Operating Condition Codes' AS "defaultSourceCodeGroup",
		dsc.default_source_cd_description AS "defaultSourceCodeDescription",
		camdecmpswks.format_date_hour(md.begin_date, md.begin_hour, null) AS "beginDateHour",
		camdecmpswks.format_date_hour(md.end_date, md.end_hour, null) AS "endDateHour"
	FROM camdecmpswks.monitor_default md
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	JOIN camdecmpsmd.parameter_code pc USING(parameter_cd)
	LEFT JOIN camdecmpsmd.operating_condition_code occ USING(operating_condition_cd)		
	LEFT JOIN camdecmpsmd.default_purpose_code dpc USING(default_purpose_cd)
	LEFT JOIN camdecmpsmd.default_source_code dsc USING(default_source_cd)
	LEFT JOIN camdecmpsmd.fuel_code fc USING(fuel_cd)
	LEFT JOIN camdecmpsmd.units_of_measure_code uom ON md.default_uom_cd = uom.uom_cd
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
    LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, md.parameter_cd, md.begin_date, md.begin_hour;
$BODY$;
