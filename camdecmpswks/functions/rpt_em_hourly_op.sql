-- FUNCTION: camdecmpswks.rpt_em_hourly_op(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_hourly_op(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_hourly_op(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "beginDate" date, "beginHour" numeric, "opTime" numeric, "hrLoad" numeric, "loadRange" numeric, "commonStackLoadRange" numeric, "fcFactor" numeric, "fdFactor" numeric, "fwFactor" numeric, "fuelCdList" character varying, "multiFuelFlg" character varying, "mhhiIndiciator" numeric, "matsLoad" numeric, "matsStartupShutdownFlg" character varying, "loadUomCode" character varying, "loadUomCodeGroup" text, "loadUomCodeDescription" character varying, "operatingConditionCode" character varying, "operatingConditionCodeGroup" text, "operatingConditionCodeDescription" character varying, "fuelCode" character varying, "fuelCodeGroup" text, "fuelCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(hop.mon_loc_id) as "location",

        hop.begin_date as "beginDate",
        hop.begin_hour as "beginHour",
        hop.op_time as "opTime",
        hop.hr_load as "hrLoad",
        hop.load_range as "loadRange",
        hop.common_stack_load_range as "commonStackLoadRange",
        hop.fc_factor as "fcFactor",
        hop.fd_factor as "fdFactor",
        hop.fw_factor as "fwFactor",
        hop.fuel_cd as "fuelCd",
        hop.multi_fuel_flg as "multiFuelFlg",
        hop.mhhi_indicator as "mhhiIndiciator",
        hop.mats_load as "matsLoad",
        hop.mats_startup_shutdown_flg as "matsStartupShutdownFlg",

        hop.load_uom_cd as "loadUomCode",
        'Units of Measure Codes ' as "loadUomCodeGroup",
        uomc.uom_cd_description as "loadUomCodeDescription",

        hop.operating_condition_cd as "operatingConditionCode",
        'Operating Condition Codes' as "operatingConditionCodeGroup",
        occ.op_condition_cd_description as "operatingConditionCodeDescription",

        hop.fuel_cd_list as "fuelCode",
        'Fuel Codes' as "fuelCodeGroup",
        fc.fuel_cd_description as "fuelCodeDescription"
		
    FROM camdecmpswks.hrly_op_data hop
	left join camdecmpsmd.fuel_code fc using (fuel_cd)
    left join camdecmpsmd.units_of_measure_code uomc on hop.load_uom_cd = uomc.uom_cd
    left join camdecmpsmd.operating_condition_code occ using (operating_condition_cd)

    WHERE hop.mon_loc_id = ANY (monLocIds) and hop.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_hourly_op(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
