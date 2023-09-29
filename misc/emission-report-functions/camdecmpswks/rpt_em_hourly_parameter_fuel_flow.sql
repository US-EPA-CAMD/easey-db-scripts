-- FUNCTION: camdecmpswks.rpt_em_hourly_parameter_fuel_flow(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_hourly_parameter_fuel_flow(text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_hourly_parameter_fuel_flow(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "systemIdentifier" character varying, "formulaIdentifier" character varying, "paramValFuel" numeric, "calcParamValFuel" numeric, "segmentNum" numeric, "calcAppeStatus" character varying, "parameterCode" character varying, "parameterCodeGroup" text, "parameterCodeDescription" character varying, "sampleTypeCode" character varying, "sampleTypeCodeGroup" text, "sampleTypeCodeDescription" character varying, "operatingConditionCode" character varying, "operatingConditionCodeGroup" text, "operatingConditionCodeDescription" character varying, "parameterUomCode" character varying, "parameterUomCodeGroup" text, "parameterUomCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(hpff.mon_loc_id) as "location",
		ms.system_identifier as "systemIdentifier",
        mf.formula_identifier as "formulaIdentifier",
        hpff.param_val_fuel as "paramValFuel",
        hpff.calc_param_val_fuel as "calcParamValFuel",
        hpff.segment_num as "segmentNum",
        hpff.calc_appe_status as "calcAppeStatus",

        hpff.parameter_cd as "parameterCode",
        'Parameter Codes' as "parameterCodeGroup",
        pc.parameter_cd_description as "parameterCodeDescription",

        hpff.sample_type_cd as "sampleTypeCode",
        'Sample Type Codes' as "sampleTypeCodeGroup",
        stc.sample_type_cd_description as "sampleTypeCodeDescription",

        hpff.operating_condition_cd as "operatingConditionCode",
        'Operating Condition Codes' as "operatingConditionCodeGroup",
        occ.op_condition_cd_description as "operatingConditionCodeDescription",

        hpff.parameter_uom_cd as "parameterUomCode",
        'Parameter Unit of Measure Codes' as "parameterUomCodeGroup",
        uomc.uom_cd_description as "parameterUomCodeDescription"
		
    FROM camdecmpswks.hrly_param_fuel_flow hpff
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
    left join camdecmpswks.monitor_formula mf using (mon_form_id)
    left join camdecmpsmd.parameter_code pc ON pc.parameter_cd = hpff.parameter_cd
    left join camdecmpsmd.units_of_measure_code uomc on uomc.uom_cd = hpff.parameter_uom_cd
    left join camdecmpsmd.sample_type_code stc using (sample_type_cd)
    left join camdecmpsmd.operating_condition_code occ using (operating_condition_cd)
    WHERE hpff.mon_loc_id = ANY (monLocIds) and hpff.rpt_period_id = rptperiodid; 
END;
$BODY$;