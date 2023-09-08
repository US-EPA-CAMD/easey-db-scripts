-- FUNCTION: camdecmpswks.rpt_em_nsps4t_fourth_quarter(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_nsps4t_fourth_quarter(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_nsps4t_fourth_quarter(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "annualEnergySold" numeric, "annualPotentialOutput" numeric, "annualEnergySoldTypeCode" character varying, "annualEnergySoldTypeCodeGroup" text, "annualEnergySoldTypeCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(na.mon_loc_id) as "location",
        na.annual_energy_sold as "annualEnergySold",
        na.annual_potential_output as "annualPotentialOutput",
        
        na.annual_energy_sold_type_cd as "annualEnergySoldTypeCode",
        'Annual Energy Sold Type Codes' as "annualEnergySoldTypeCodeGroup",
        elc.electrical_load_description as "annualEnergySoldTypeCodeDescription"

    FROM camdecmpswks.nsps4t_annual na
    left join camdecmpsmd.nsps4t_electrical_load_code elc on elc.electrical_load_cd = na.annual_energy_sold_type_cd
    WHERE na.mon_loc_id = ANY (monLocIds) and na.rpt_period_id = rptperiodid; 
END;
$BODY$;