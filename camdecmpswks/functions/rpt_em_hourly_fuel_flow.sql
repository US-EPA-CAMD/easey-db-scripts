-- FUNCTION: camdecmpswks.rpt_em_hourly_fuel_flow(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_hourly_fuel_flow(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_hourly_fuel_flow(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "systemIdentifier" character varying, "fuelUsageTime" numeric, "volumetricFlowRate" numeric, "massFlowRate" numeric, "calcVolumetricFlowRate" numeric, "calcAppdStatus" character varying, "sodMassCode" character varying, "sodMassCodeGroup" text, "sodMassCodeDescription" character varying, "sodVolumetricCode" character varying, "sodVolumetricCodeGroup" text, "sodVolumetricCodeDescription" character varying, "volumetricUomCode" character varying, "volumetricUomCodeGroup" text, "volumetricUomCodeDescription" character varying, "fuelCode" character varying, "fuelCodeGroup" text, "fuelCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(hff.mon_loc_id) as "location",
		ms.system_identifier as "systemIdentifier",
        hff.fuel_usage_time as "fuelUsageTime",
        hff.volumetric_flow_rate as "volumetricFlowRate",
        hff.mass_flow_rate as "massFlowRate",
        hff.calc_volumetric_flow_rate as "calcVolumetricFlowRate",
        hff.calc_appd_status as "calcAppdStatus",

        hff.sod_mass_cd as "sodMassCode",
        'Source of Mass Flow Rate Codes' as "sodMassCodeGroup",
        smc.sod_mass_cd_description as "sodMassCodeDescription",

        hff.sod_volumetric_cd as "sodVolumetricCode",
        'Source of Volumetric Flow Rate Code' as "sodVolumetricCodeGroup",
        svc.sod_volumetric_cd_description as "sodVolumetricCodeDescription",

        hff.volumetric_uom_cd as "volumetricUomCode",
        'Units of Measure Code' as "volumetricUomCodeGroup",
        uomc.uom_cd_description as "volumetricUomCodeDescription",

        hff.fuel_cd as "fuelCode",
        'Fuel Codes' as "fuelCodeGroup",
        fc.fuel_cd_description as "fuelCodeDescription"
		
    FROM camdecmpswks.hrly_fuel_flow hff
	left join camdecmpsmd.fuel_code fc using (fuel_cd)
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
    left join camdecmpsmd.sod_volumetric_code svc using (sod_volumetric_cd)
    left join camdecmpsmd.sod_mass_code smc using (sod_mass_cd)
    left join camdecmpsmd.units_of_measure_code uomc on uomc.uom_cd = hff.volumetric_uom_cd
    WHERE hff.mon_loc_id = ANY (monLocIds) and hff.rpt_period_id = rptperiodid; 
END;
$BODY$;
