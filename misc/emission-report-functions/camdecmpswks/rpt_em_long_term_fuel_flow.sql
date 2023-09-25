-- FUNCTION: camdecmpswks.rpt_em_long_term_fuel_flow(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_long_term_fuel_flow(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_long_term_fuel_flow(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "systemIdentifier" character varying, "longTermFuelFlowValue" numeric, "grossCalorificValue" numeric, "totalHeatInput" numeric, "calcTotalHeatInput" numeric, "fuelFlowPeriodCode" character varying, "fuelFlowPeriodCodeGroup" text, "fuelFlowPeriodCodeDescription" character varying, "ltffUomCode" character varying, "ltffUomCodeGroup" text, "ltffUomCodeDescription" character varying, "gcvUomCode" character varying, "gcvUomCodeGroup" text, "gcvUomCodeDescription" character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE 
    monLocIds character varying[];
	rptperiodid numeric;
BEGIN

	SELECT rpt_period_id 
	INTO rptperiodid
	FROM camdecmpsmd.reporting_period
	WHERE calendar_year = vyear and quarter = vquarter;

    SELECT ARRAY(
        SELECT mon_loc_id
        FROM camdecmpswks.monitor_plan_location
        WHERE mon_plan_id = monplanid 
    ) INTO monLocIds;

    RETURN QUERY
    SELECT
        camdecmpswks.get_config_by_loc_id(ltff.mon_loc_id) as "location",
		ms.system_identifier as "systemIdentifier",
        ltff.long_term_fuel_flow_value as "longTermFuelFlowValue",
        ltff.gross_calorific_value as "grossCalorificValue",
        ltff.total_heat_input as "totalHeatInput",
        ltff.calc_total_heat_input as "calcTotalHeatInput",
        
        ltff.fuel_flow_period_cd as "fuelFlowPeriodCode",
        'Fuel Flow Period Codes' as "fuelFlowPeriodCodeGroup",
        ffpc.ff_period_cd_description as "fuelFlowPeriodCodeDescription",

        ltff.ltff_uom_cd as "ltffUomCode",
        'LTFF Unit of Measure Codes' as "ltffUomCodeGroup",
        uomc.uom_cd_description as "ltffUomCodeDescription",

        ltff.gcv_uom_cd as "gcvUomCode",
        'GCV Unit of Measure Codes' as "gcvUomCodeGroup",
        uomc.uom_cd_description as "gcvUomCodeDescription"
		
    FROM camdecmpswks.long_term_fuel_flow ltff
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
    left join camdecmpsmd.units_of_measure_code uomc on uomc.uom_cd = ltff.ltff_uom_cd and uomc.uom_cd = ltff.gcv_uom_cd
    left join camdecmpsmd.fuel_flow_period_code ffpc using (fuel_flow_period_cd)
    WHERE ltff.mon_loc_id = ANY (monLocIds) and ltff.rpt_period_id = rptperiodid; 
END;
$BODY$;