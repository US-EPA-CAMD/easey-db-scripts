-- FUNCTION: camdecmpswks.rpt_em_mats_derived_hourly_value(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_mats_derived_hourly_value(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_mats_derived_hourly_value(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "formulaIdentifier" character varying, "unadjustedHourlyValue" character varying, "calcUnadjustedHourlyValue" character varying, "calcPctDiluent" numeric, "calcPctMoisture" numeric, "modcCode" character varying, "modcCodeGroup" text, "modcCodeDescription" character varying, "parameterCode" character varying, "parameterCodeGroup" text, "parameterCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(mdhv.mon_loc_id) as "location",
        mf.formula_identifier as "formulaIdentifier",
        mdhv.unadjusted_hrly_value as "unadjustedHourlyValue",
        mdhv.calc_unadjusted_hrly_value as "calcUnadjustedHourlyValue",
        mdhv.calc_pct_diluent as "calcPctDiluent",
        mdhv.calc_pct_moisture as "calcPctMoisture",

        mdhv.modc_cd as "modcCode",
        'Method of Determination Codes' as "modcCodeGroup",
        mc.modc_description as "modcCodeDescription",

        mdhv.parameter_cd as "parameterCode",
        'Parameter Codes' as "parameterCodeGroup",
        pc.parameter_cd_description as "parameterCodeDescription"
		
    FROM camdecmpswks.mats_derived_hrly_value mdhv
    left join camdecmpswks.monitor_formula mf using (mon_form_id)
    left join camdecmpsmd.parameter_code pc ON pc.parameter_cd = mdhv.parameter_cd
	left join camdecmpsmd.modc_code mc using (modc_cd)
    WHERE mdhv.mon_loc_id = ANY (monLocIds) and mdhv.rpt_period_id = rptperiodid; 
END;
$BODY$;