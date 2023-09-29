-- FUNCTION: camdecmpswks.rpt_em_nsps4t_compliance_period(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_nsps4t_compliance_period(text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_nsps4t_compliance_period(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "beginYear" numeric, "beginMonth" numeric, "endYear" numeric, "endMonth" numeric, "avgCo2EmissionRate" numeric, "pctValidOpHours" numeric, "co2ViolationInd" numeric, "co2ViolationComment" character varying, "co2EmissionRateUomCode" character varying, "co2EmissionRateUomCodeGroup" text, "co2EmissionRateUomCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(ncp.mon_loc_id) as "location",
        ncp.begin_year as "beginYear",
        ncp.begin_month as "beginMonth",
        ncp.end_year as "endYear",
        ncp.end_month as "endMonth",
        ncp.avg_co2_emission_rate as "avgCo2EmissionRate",
        ncp.pct_valid_op_hours as "pctValidOpHours",
        ncp.co2_violation_ind as "co2ViolationInd",
        ncp.co2_violation_comment as "co2ViolationComment",
       
        ncp.co2_emission_rate_uom_cd as "co2EmissionRateUomCode",
        'CO2 Emission Rate Units of Measure Codes' as "co2EmissionRateUomCodeGroup",
        uomc.uom_cd_description as "co2EmissionRateUomCodeDescription"

    FROM camdecmpswks.nsps4t_compliance_period ncp
    left join camdecmpsmd.units_of_measure_code uomc on uomc.uom_cd = ncp.co2_emission_rate_uom_cd
    WHERE ncp.mon_loc_id = ANY (monLocIds) and ncp.rpt_period_id = rptperiodid; 
END;
$BODY$;