-- FUNCTION: camdecmpswks.rpt_em_mats_monitor_hourly_value(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_mats_monitor_hourly_value(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_mats_monitor_hourly_value(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "systemIdentifier" character varying, "componentIdentifier" character varying, "unadjustedHourlyValue" character varying, "pctAvailable" numeric, "calcUnadjustedHourlyValue" character varying, "calcDailyCalStatus" character varying, "calcHgLineStatus" character varying, "calcHgi1Status" character varying, "calcRataStatus" character varying, "modcCode" character varying, "methodOfDeterminationCodeGroup" text, "methodOfDeterminationDescription" character varying, "parameterCode" character varying, "parameterCodeGroup" text, "parameterCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(mmhv.mon_loc_id) as "location",
		ms.system_identifier as "systemIdentifier",
		c.component_identifier as "componentIdentifier",
        mmhv.unadjusted_hrly_value as "unadjustedHourlyValue",
        mmhv.pct_available as "pctAvailable",
        mmhv.calc_unadjusted_hrly_value as "calcUnadjustedHourlyValue",
        mmhv.calc_daily_cal_status as "calcDailyCalStatus",
        mmhv.calc_hg_line_status as "calcHgLineStatus",
        mmhv.calc_hgi1_status as "calcHgi1Status",
        mmhv.calc_rata_status as "calcRataStatus",

        mmhv.modc_cd as "modcCode",
        'Method of Determination Codes' as "modcCodeGroup",
        mc.modc_description as "modcCodeDescription",

        mmhv.parameter_cd as "parameterCode",
        'Parameter Codes' as "parameterCodeGroup",
        pc.parameter_cd_description as "parameterCodeDescription"
		
    FROM camdecmpswks.mats_monitor_hrly_value mmhv
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
	left join camdecmpswks.component c using (component_id)
    left join camdecmpsmd.parameter_code pc using (parameter_cd)
	left join camdecmpsmd.modc_code mc using (modc_cd)
    WHERE mmhv.mon_loc_id = ANY (monLocIds) and mmhv.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_mats_monitor_hourly_value(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
