-- FUNCTION: camdecmpswks.rpt_em_daily_fuel(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_daily_fuel(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_daily_fuel(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "fuelCode" character varying, "fuelCodeGroup" text, "fuelCodeDescription" character varying, "dailyFuelFeed" numeric, "carbonContentUsed" numeric, "fuelCarbonBurned" numeric, "calcFuelCarbonBurned" numeric) 
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
        camdecmpswks.get_config_by_loc_id(df.mon_loc_id) as "location",

        df.fuel_cd as "fuelCode",
        'Fuel Codes' as "fuelCodeGroup",
        fc.fuel_cd_description as "fuelCodeDescription",

        df.daily_fuel_feed as "dailyFuelFeed",
        df.carbon_content_used as "carbonContentUsed",
        df.fuel_carbon_burned as "fuelCarbonBurned",
        df.calc_fuel_carbon_burned as "calcFuelCarbonBurned"
		
    FROM camdecmpswks.daily_fuel df
	left join camdecmpsmd.fuel_code fc using (fuel_cd)
    WHERE df.mon_loc_id = ANY (monLocIds) and df.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_daily_fuel(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
