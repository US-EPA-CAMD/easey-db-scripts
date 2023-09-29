-- FUNCTION: camdecmpswks.rpt_mp_system_fuel_flow(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_mp_system_fuel_flow(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_system_fuel_flow(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "systemIdentifier" text, "fuelCode" text, "fuelCodeGroup" text, "fuelCodeDescription" text, "maxFuelFlowRate" numeric, "unitsOfMeasureCode" text, "unitsOfMeasureCodeGroup" text, "unitsOfMeasureCodeDescription" text, "maxRateSourceCode" text, "maxRateSourceCodeGroup" text, "maxRateSourceCodeDescription" text, "beginDateHour" text, "endDateHour" text) 
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
		ms.system_identifier AS "systemIdentifier",
		ms.fuel_cd AS "fuelCode",
		'Fuel Codes' AS "fuelCodeGroup",		
		fc.fuel_cd_description AS "fuelCodeDescription",
		sff.max_rate AS "maxFuelFlowRate",
		sff.sys_fuel_uom_cd AS "unitsOfMeasureCode",
		'Units of Measure' AS "unitsOfMeasureCodeGroup",
		uom.uom_cd_description AS "unitsOfMeasureCodeDescription",
		sff.max_rate_source_cd AS "maxRateSourceCode",
		'Max Rate Source Codes' AS "maxRateSourceGroup",
		mrsc.max_rate_source_cd_description AS "maxRateSourceDescription",
		camdecmpswks.format_date_hour(sff.begin_date, sff.begin_hour, null) AS "beginDateHour",
		camdecmpswks.format_date_hour(sff.end_date, sff.end_hour, null) AS "endDateHour"
	FROM camdecmpswks.system_fuel_flow sff
	JOIN camdecmpswks.monitor_system ms USING(mon_sys_id)
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	JOIN camdecmpsmd.units_of_measure_code uom ON sff.sys_fuel_uom_cd = uom.uom_cd
	LEFT JOIN camdecmpsmd.fuel_code fc USING(fuel_cd)
	LEFT JOIN camdecmpsmd.max_rate_source_code mrsc USING(max_rate_source_cd)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
    LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId;
$BODY$;
