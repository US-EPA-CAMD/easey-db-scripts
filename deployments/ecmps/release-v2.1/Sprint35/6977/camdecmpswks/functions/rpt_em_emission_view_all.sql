-- FUNCTION: camdecmpswks.rpt_em_emission_view_all(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_emission_view_all(text, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_emission_view_all(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(
        location character varying, 
        "dateHour" character varying, 
        "opTime" text,
        "unitLoad" numeric, 
        "loadUomCode" character varying, 
        "loadUomCodeGroup" text, 
        "loadUomCodeDescription" character varying, 
        "hiFormulaCode" character varying, 
        "hiFormulaCodeGroup" text, 
        "hiFormulaCodeDescription" character varying, 
        "rptHiRate" text,
        "calcHiRate" text,
        "so2FormulaCode" character varying, 
        "so2FormulaCodeGroup" text, 
        "so2FormulaCodeDescription" character varying, 
        "rptSo2MassRate" text,
        "calcSo2MassRate" text,
        "noxRateFormulaCode" character varying, 
        "noxRateFormulaCodeGroup" text, 
        "noxRateFormulaCodeDescription" character varying, 
        "rptAdjNoxRate" text,
        "calcAdjNoxRate" text,
        "noxMassFormulaCode" character varying, 
        "noxMassFormulaCodeGroup" text, 
        "noxMassFormulaCodeDescription" character varying, 
        "rptNoxMass" text,
        "calcNoxMass" text,
        "co2FormulaCode" character varying, 
        "co2FormulaCodeGroup" text, 
        "co2FormulaCodeDescription" character varying, 
        "rptCo2MassRate" text,
        "calcCo2MassRate" text,
        "errorCodes" character varying, 
        "adjFlowUsed" numeric, 
        "rptAdjFlow" numeric, 
        "unadjFlow" numeric
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
        FROM camdecmpswks.monitor_plan_location
        WHERE mon_plan_id = monplanid 
    ) INTO monLocIds;

    RETURN QUERY
    SELECT
        camdecmpswks.get_config_by_loc_id(eva.mon_loc_id) as "location",
        eva.date_hour as "dateHour",
        TO_CHAR(eva.op_time, 'FM999999999990.00') as "opTime",
        eva.unit_load as "unitLoad",

        eva.load_uom as "loadUomCode",
        'Load Unit of Measure Codes' as "loadUomCodeGroup",
        uomc.uom_cd_description as "loadUomCodeDescription",

        eva.hi_formula_cd as "hiFormulaCode",
        'Hi Formula Codes' as "hiFormulaCodeGroup",
        echi.equation_cd_description as "hiFormulaCodeDescription", 

        TO_CHAR(eva.rpt_hi_rate, 'FM999999999990') as "rptHiRate",
        TO_CHAR(eva.calc_hi_rate, 'FM999999999990') as "calcHiRate",

        eva.so2_formula_cd as "so2FormulaCode",
        'So2 Formula Codes' as "so2FormulaCodeGroup",
        ecso2.equation_cd_description as "so2FormulaCodeDescription",

        TO_CHAR(eva.rpt_so2_mass_rate, 'FM999999999990.0') as "rptSo2MassRate",
        TO_CHAR(eva.calc_so2_mass_rate, 'FM999999999990.0') as "calcSo2MassRate",

        eva.nox_rate_formula_cd as "noxRateFormulaCode",
        'Nox Rate Formula Codes' as "noxRateFormulaCodeGroup",
        ecnr.equation_cd_description as "noxRateFormulaCodeDescription",  

        TO_CHAR(eva.rpt_adj_nox_rate, 'FM999999999990.000') as "rptAdjNoxRate",
        TO_CHAR(eva.calc_adj_nox_rate, 'FM999999999990.000') as "calcAdjNoxRate",

        eva.nox_mass_formula_cd as "noxMassFormulaCode",
        'Nox Mass Formula Codes' as "noxMassFormulaCodeGroup",
        ecnm.equation_cd_description as "noxMassFormulaCodeDescription",

        TO_CHAR(eva.rpt_nox_mass, 'FM999999999990.0') as "rptNoxMass",
        TO_CHAR(eva.calc_nox_mass, 'FM999999999990.0') as "calcNoxMass",

        eva.co2_formula_cd as "co2FormulaCode",
        'Co2 Formula Codes' as "co2FormulaCodeGroup",
        ecco2.equation_cd_description as "co2FormulaCodeDescription",

        TO_CHAR(eva.rpt_co2_mass_rate, 'FM999999999990.0') as "rptCo2MassRate",
        TO_CHAR(eva.calc_co2_mass_rate, 'FM999999999990.0') as "calcCo2MassRate",       
        eva.error_codes as "errorCodes",
        eva.adj_flow_used as "adjFlowUsed",
        eva.rpt_adj_flow as "rptAdjFlow",
        eva.unadj_flow as "unadjFlow"
		
    FROM camdecmpswks.emission_view_all eva
    left join camdecmpsmd.units_of_measure_code uomc on uomc.uom_cd = eva.load_uom
    left join camdecmpsmd.equation_code echi on echi.equation_cd = eva.hi_formula_cd 
    left join camdecmpsmd.equation_code ecso2 on ecso2.equation_cd = eva.so2_formula_cd 
    left join camdecmpsmd.equation_code ecnr on ecnr.equation_cd = eva.nox_rate_formula_cd 
    left join camdecmpsmd.equation_code ecnm on ecnm.equation_cd = eva.nox_mass_formula_cd 
    left join camdecmpsmd.equation_code ecco2 on ecco2.equation_cd = eva.co2_formula_cd 

    WHERE eva.mon_loc_id = ANY (monLocIds) and eva.rpt_period_id = rptperiodid; 
END;
$BODY$;
