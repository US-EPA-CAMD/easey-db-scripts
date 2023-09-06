-- FUNCTION: camdecmpswks.rpt_em_sorbent_trap(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_sorbent_trap(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_sorbent_trap(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "beginDate" date, "beginHour" numeric, "endDate" date, "endHour" numeric, "systemIdentifier" character varying, "pairedTrapAgreement" numeric, "absoluteDifferenceInd" numeric, "hgConcentration" character varying, "calcPairedTrapAgreement" numeric, "calcHgConcentration" character varying, "rataInd" numeric, "modcCode" character varying, "modcCodeGroup" text, "modcCodeDescription" character varying, "calcModcCode" character varying, "calcModcCodeGroup" text, "calcModcCodeDescription" character varying, "sorbentTrapApsCode" character varying, "sorbentTrapApsCodeGroup" text, "sorbentTrapApsCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(st.mon_loc_id) as "location",
        st.begin_date as "beginDate",
        st.begin_hour as "beginHour",
        st.end_date as "endDate",
        st.end_hour as "endHour",
        ms.system_identifier as "systemIdentifier",
        st.paired_trap_agreement as "pairedTrapAgreement",
        st.absolute_difference_ind as "absoluteDifferenceInd",
        st.hg_concentration as "hgConcentration",
        st.calc_paired_trap_agreement as "calcPairedTrapAgreement",
        st.calc_hg_concentration as "calcHgConcentration",
        st.rata_ind as "rataInd",

        
        st.modc_cd as "modcCode",
        'Method of Determination Codes' as "modcCodeGroup",
        mc.modc_description as "modcCodeDescription",

        st.calc_modc_cd as "calcModcCode",
        'Calc Method of Determination Codes' as "calcModcCodeGroup",
        mc.modc_description as "calcModcCodeDescription",

        st.sorbent_trap_aps_cd as "sorbentTrapApsCode",
        'Sorbent Trap aps code' as "sorbentTrapApsCodeGroup",
        stac.sorbent_trap_aps_description as "sorbentTrapApsCodeDescription"

		
    FROM camdecmpswks.sorbent_trap st
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
	left join camdecmpsmd.modc_code mc using (modc_cd)
    left join camdecmpsmd.sorbent_trap_aps_code stac using (sorbent_trap_aps_cd)
    WHERE st.mon_loc_id = ANY (monLocIds) and st.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_sorbent_trap(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
