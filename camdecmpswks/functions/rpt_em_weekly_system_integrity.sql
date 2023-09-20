-- FUNCTION: camdecmpswks.rpt_em_weekly_system_integrity(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_weekly_system_integrity(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_weekly_system_integrity(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "refValue" numeric, "measuredValue" numeric, "systemIntegrityError" numeric, "apsInd" numeric, "calcSystemIntegrityError" numeric, "calcApsInd" numeric, "gasLevelCode" character varying, "gasLevelCodeGroup" text, "gasLevelCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(wsi.mon_loc_id) as "location",
        wsi.ref_value as "refValue",
        wsi.measured_value as "measuredValue",
        wsi.system_integrity_error as "systemIntegrityError",
        wsi.aps_ind as "apsInd",
        wsi.calc_system_integrity_error as "calcSystemIntegrityError",
        wsi.calc_aps_ind as "calcApsInd",
		
		wsi.gas_level_cd as "gasLevelCode",
		'Gas Level Codes' AS "gasLevelCodeGroup",
		glc.gas_level_description as "gasLevelCodeDescription"
		
		
    FROM camdecmpswks.weekly_system_integrity wsi
	left join camdecmpsmd.gas_level_code glc using (gas_level_cd)
    WHERE wsi.mon_loc_id = ANY (monLocIds) and wsi.rpt_period_id = rptperiodid; 
END;
$BODY$;