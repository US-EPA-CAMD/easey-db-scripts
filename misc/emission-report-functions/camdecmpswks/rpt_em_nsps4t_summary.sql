-- FUNCTION: camdecmpswks.rpt_em_nsps4t_summary(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_nsps4t_summary(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_nsps4t_summary(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "modusValue" numeric, "noPeriodEndedInd" numeric, "noPeriodEndedComment" character varying, "modusUomCode" character varying, "modusUomCodeGroup" text, "modusUomCodeDescription" character varying, "electricalLoadCode" character varying, "electricalLoadCodeGroup" text, "electricalLoadCodeDescription" character varying, "emissionStandardCode" character varying, "emissionStandardCodeGroup" text, "emissionStandardCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(ns.mon_loc_id) as "location",
        ns.modus_value as "modusValue",
        ns.no_period_ended_ind as "noPeriodEndedInd",
        ns.no_period_ended_comment as "noPeriodEndedComment",
        
        ns.modus_uom_cd as "modusUomCode",
        'Modus Units of Measure Codes' as "modusUomCodeGroup",
        uomc.uom_cd_description as "modusUomCodeDescription",

        ns.electrical_load_cd as "electricalLoadCode",
        'Electrical Load Codes' as "electricalLoadCodeGroup",
        elc.electrical_load_description as "electricalLoadCodeDescription",

        ns.emission_standard_cd as "emissionStandardCode",
        'Emission Standard code' as "emissionStandardCodeGroup",
        esc.emission_standard_description as "emissionStandardCodeDescription"

		
    FROM camdecmpswks.nsps4t_summary ns
    left join camdecmpsmd.nsps4t_emission_standard_code esc using (emission_standard_cd)
    left join camdecmpsmd.nsps4t_electrical_load_code  elc using (electrical_load_cd)
    left join camdecmpsmd.units_of_measure_code uomc on uomc.uom_cd = ns.modus_uom_cd
    WHERE ns.mon_loc_id = ANY (monLocIds) and ns.rpt_period_id = rptperiodid; 
END;
$BODY$;