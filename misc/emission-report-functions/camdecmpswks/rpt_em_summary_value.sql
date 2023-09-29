-- FUNCTION: camdecmpswks.rpt_em_summary_value(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_summary_value(text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_summary_value(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "parameterCode" character varying, "parameterCodeGroup" text, "parameterCodeDescription" character varying, "currentRptPeriodTotal" numeric, "calcCurrentRptPeriodTotal" numeric, "osTotal" numeric, "calcOsTotal" numeric, "yearTotal" numeric, calcyeartotal numeric) 
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
        camdecmpswks.get_config_by_loc_id(sv.mon_loc_id) as "location",

        sv.parameter_cd as "parameterCode",
		'Parameter Codes' AS "parameterCodeGroup",
		pc.parameter_cd_description as "parameterCodeDescription",

        sv.current_rpt_period_total as "currentRptPeriodTotal",
        sv.calc_current_rpt_period_total as "calcCurrentRptPeriodTotal",
        sv.os_total as "osTotal",
        sv.calc_os_total as "calcOsTotal", 
        sv.year_total as "yearTotal",
        sv.calc_year_total as "calcYearTotal"
    FROM camdecmpswks.summary_value sv
	join camdecmpsmd.parameter_code pc using (parameter_cd)
    WHERE sv.mon_loc_id = ANY (monLocIds) and sv.rpt_period_id = rptperiodid; 
END;
$BODY$;