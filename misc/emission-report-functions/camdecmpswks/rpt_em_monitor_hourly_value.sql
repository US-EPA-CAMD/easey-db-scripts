-- FUNCTION: camdecmpswks.rpt_em_monitor_hourly_value(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_monitor_hourly_value(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_monitor_hourly_value(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "systemIdentifier" character varying, "componentIdentifier" character varying, "applicableBiasAdjFactor" numeric, "unadjustedHourlyValue" numeric, "adjustedHourlyValue" numeric, "calcAdjustedHourlyValue" numeric, "pctAvailable" numeric, "mositureBasis" character varying, "calcLineStatus" character varying, "calcRataStatus" character varying, "calcDaycalStatus" character varying, "calcLeakStatus" character varying, "calcDayintStatus" character varying, "calcf21Status" character varying, "modcCode" character varying, "modcCodeGroup" text, "modcCodeDescription" character varying, "parameterCode" character varying, "parameterCodeGroup" text, "parameterCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(mhv.mon_loc_id) as "location",
		ms.system_identifier as "systemIdentifier",
		c.component_identifier as "componentIdentifier",
        mhv.applicable_bias_adj_factor as "applicableBiasAdjFactor",
        mhv.unadjusted_hrly_value as "unadjustedHourlyValue",
        mhv.adjusted_hrly_value as "adjustedHourlyValue",
        mhv.calc_adjusted_hrly_value as "calcAdjustedHourlyValue",
        mhv.pct_available as "pctAvailable",
        mhv.moisture_basis as "moistureBasis",
        mhv.calc_line_status as "calcLineStatus",
        mhv.calc_rata_status as "calcRataStatus",
        mhv.calc_daycal_status as "calcDaycalStatus",
        mhv.calc_leak_status as "calcLeakStatus",
        mhv.calc_dayint_status as "calcDayintStatus",
        mhv.calc_f2l_status as "calcf21Status",

        mhv.modc_cd as "modcCode",
        'Method of Determination Codes' as "modcCodeGroup",
        mc.modc_description as "modcCodeDescription",

        mhv.parameter_cd as "parameterCode",
        'Parameter Codes' as "parameterCodeGroup",
        pc.parameter_cd_description as "parameterCodeDescription"
		
    FROM camdecmpswks.monitor_hrly_value mhv
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
	left join camdecmpswks.component c using (component_id)
    left join camdecmpsmd.parameter_code pc using (parameter_cd)
	left join camdecmpsmd.modc_code mc using (modc_cd)
    WHERE mhv.mon_loc_id = ANY (monLocIds) and mhv.rpt_period_id = rptperiodid; 
END;
$BODY$;
