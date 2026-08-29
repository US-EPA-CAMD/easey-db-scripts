-- FUNCTION: camdecmps.rpt_em_daily_backstop(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmps.rpt_em_daily_backstop(text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_em_daily_backstop(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(
        location character varying, 
        "opDate" date,
        "dailyNoxm" text,
        "dailyHit" text,
        "dailyAvgNoxr" text,
        "dailyNoxmExceed" text,
        "cumulativeOsNoxmExceed" text
    ) 
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
        FROM camdecmps.monitor_plan_location
        WHERE mon_plan_id = monplanid 
    ) INTO monLocIds;

    RETURN QUERY
    SELECT
        camdecmps.get_config_by_loc_id(db.mon_loc_id) as "location",
        db.op_date as "opDate",
        TO_CHAR(db.daily_noxm, 'FM999999999990.0') as "dailyNoxm",
        TO_CHAR(db.daily_hit, 'FM999999999990') as "dailyHit",
        TO_CHAR(db.daily_avg_noxr, 'FM999999999990.000') as "dailyAvgNoxr",
        TO_CHAR(db.daily_noxm_exceed, 'FM999999999990.0') as "dailyNoxmExceed", -- 1 decimal place
        TO_CHAR(db.cumulative_os_noxm_exceed, 'FM999999999990.0') as "cumulativeOsNoxmExceed"
    
    FROM camdecmps.daily_backstop db
    WHERE db.mon_loc_id = ANY (monLocIds) AND db.rpt_period_id = rptperiodid; 
END;
$BODY$;
