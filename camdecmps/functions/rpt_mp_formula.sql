-- FUNCTION: camdecmps.rpt_mp_formula(character varying)

DROP FUNCTION IF EXISTS camdecmps.rpt_mp_formula(character varying);

CREATE OR REPLACE FUNCTION camdecmps.rpt_mp_formula(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "parameterCode" text, "parameterCodeGroup" text, "parameterCodeDescription" text, "formulaIdentifier" text, "equationCode" text, "equationCodeGroup" text, "equationCodeDescription" text, "equationFormula" text, "beginDateHour" text, "endDateHour" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		mf.parameter_cd AS "parameterCode",
		'Parameter Codes' AS "parameterCodeGroup",		
		pc.parameter_cd_description AS "parameterCodeDescription",
		mf.formula_identifier AS "formulaIdentifier",
		mf.equation_cd AS "equationCode",
		'Equation Codes' AS "equationCodeGroup",
		ec.equation_cd_description AS "equationCodeDescription",
		mf.formula_equation AS "formulaEquation",
		camdecmps.format_date_hour(mf.begin_date, mf.begin_hour, null) AS "beginDateHour",
		camdecmps.format_date_hour(mf.end_date, mf.end_hour, null) AS "endDateHour"
	FROM camdecmps.monitor_formula mf
	JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	JOIN camdecmpsmd.parameter_code pc USING(parameter_cd)
	LEFT JOIN camdecmpsmd.equation_code ec USING(equation_cd)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
  	LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, mf.formula_identifier, mf.begin_date, mf.begin_hour;
$BODY$;
