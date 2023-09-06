-- FUNCTION: camdecmpswks.rpt_em_daily_emissions(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_daily_emissions(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_daily_emissions(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "parameterCode" character varying, "parameterCodeGroup" text, "parameterCodeDescription" character varying, "beginDate" date, "totalDailyEmission" numeric, "adjustedDailyEmission" numeric, "sorbentMassEmission" numeric, "unadjustedDailyEmission" numeric, "totalCarbonBurned" numeric, "calcTotalDailyEmission" numeric, "calcTotalOpTime" numeric) 
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
        camdecmpswks.get_config_by_loc_id(de.mon_loc_id) as "location",

        de.parameter_cd as "parameterCode",
        'Parameter Codes' as "parameterCodeGroup",
        pc.parameter_cd_description as "parameterCodeDescription",

        de.begin_date as "beginDate",
        de.total_daily_emission as "totalDailyEmission",
        de.adjusted_daily_emission as "adjustedDailyEmission",
        de.sorbent_mass_emission as "sorbentMassEmission",
        de.unadjusted_daily_emission as "unadjustedDailyEmission",
        de.total_carbon_burned as "totalCarbonBurned",
        de.calc_total_daily_emission as "calcTotalDailyEmission",
        de.calc_total_op_time as "calcTotalOpTime"
		
    FROM camdecmpswks.daily_emission de
	left join camdecmpsmd.parameter_code pc using (parameter_cd)
    WHERE de.mon_loc_id = ANY (monLocIds) and de.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_daily_emissions(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
