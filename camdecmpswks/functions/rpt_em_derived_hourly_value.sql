-- FUNCTION: camdecmpswks.rpt_em_derived_hourly_value(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_derived_hourly_value(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_derived_hourly_value(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "systemIdentifier" character varying, "formulaIdentifier" character varying, "applicableBiasAdjFactor" numeric, "unadjustedHourlyValue" numeric, "calcUnadjustedHourlyValue" numeric, "adjustedHourlyValue" numeric, "calcAdjustedHourlyValue" numeric, "pctAvailable" numeric, "diluentCapInd" numeric, "segmentNum" numeric, "calcPctDiluent" numeric, "calcPctMositure" numeric, "calcRataStatus" character varying, "calcAppeStatus" character varying, "calcFuelFlowTotal" numeric, "modcCode" character varying, "modcCodeGroup" text, "modcCodeDescription" character varying, "parameterCode" character varying, "parameterCodeGroup" text, "parameterCodeDescription" character varying, "operatingConditionCode" character varying, "operatingConditionCodeGroup" text, "operatingConditionCodeDescription" character varying, "fuelCode" character varying, "fuelCodeGroup" text, "fuelCodeDescription" character varying, "calcHourMeasureCode" character varying, "calcHourMeasureCodeGroup" text, "calcHourMeasureCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(dhv.mon_loc_id) as "location",
		ms.system_identifier as "systemIdentifier",
        mf.formula_identifier as "formulaIdentifier",
        dhv.applicable_bias_adj_factor as "applicableBiasAdjFactor",
        dhv.unadjusted_hrly_value as "unadjustedHourlyValue",
        dhv.calc_unadjusted_hrly_value as "calcUnadjustedHourlyValue",
        dhv.adjusted_hrly_value as "adjustedHourlyValue",
        dhv.calc_adjusted_hrly_value as "calcAdjustedHourlyValue",
        dhv.pct_available as "pctAvailable",
        dhv.diluent_cap_ind as "diluentCapInd",
        dhv.segment_num as "segmentNum",
        dhv.calc_pct_diluent as "calcPctDiluent",
        dhv.calc_pct_moisture as "calcPctMoisture",
        dhv.calc_rata_status as "calcRataStatus",
        dhv.calc_appe_status as "calcAppeStatus",
        dhv.calc_fuel_flow_total as "calcFuelFlowTotal",

        dhv.modc_cd as "modcCode",
        'Method of Determination Codes' as "modcCodeGroup",
        mc.modc_description as "modcCodeDescription",

        dhv.operating_condition_cd as "operatingConditionCode",
        'Operating Condition Codes' as "operatingConditionCodeGroup",
        occ.op_condition_cd_description as "operatingConditionCodeDescription",

        dhv.parameter_cd as "parameterCode",
        'Parameter Codes' as "parameterCodeGroup",
        pc.parameter_cd_description as "parameterCodeDescription",
        
        dhv.fuel_cd as "fuelCode",
        'Fuel Codes' as "fuelCodeGroup",
        fc.fuel_cd_description as "fuelCodeDescription",

        dhv.calc_hour_measure_cd as "calcHourMeasureCode",
		'Calc Hour Measure Codes' AS "calcHourMeasureCodeGroup",
		hmc.hour_measure_description as "calcHourMeasureCodeDescription"
		
    FROM camdecmpswks.derived_hrly_value dhv
	left join camdecmpsmd.fuel_code fc using (fuel_cd)
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
    left join camdecmpswks.monitor_formula mf using (mon_form_id)
    left join camdecmpsmd.parameter_code pc ON pc.parameter_cd = dhv.parameter_cd
	left join camdecmpsmd.modc_code mc using (modc_cd)
    left join camdecmpsmd.operating_condition_code occ using (operating_condition_cd)
    left join camdecmpsmd.hour_measure_code hmc ON hmc.hour_measure_cd = dhv.calc_hour_measure_cd
    WHERE dhv.mon_loc_id = ANY (monLocIds) and dhv.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_derived_hourly_value(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
