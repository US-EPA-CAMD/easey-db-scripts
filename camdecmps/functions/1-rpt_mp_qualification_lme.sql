-- FUNCTION: camdecmps.rpt_mp_qualification_lme(character varying)

DROP FUNCTION IF EXISTS camdecmps.rpt_mp_qualification_lme(character varying);

CREATE OR REPLACE FUNCTION camdecmps.rpt_mp_qualification_lme(
	monplanid character varying)
    RETURNS TABLE("unitStack" text, "qualificationTypeCode" text, "qualificationTypeCodeGroup" text, "qualificationTypeCodeDescription" text, "beginDate" text, "endDate" text, "qualificationYear" numeric, "operatingHours" numeric, "so2Tons" numeric, "noxTons" numeric) 
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
		mq.qual_type_cd AS "qualificationTypeCode",
		'Qualification Type Codes' AS "qualificationTypeCodeGroup",
		qtc.qual_type_cd_description AS "qualificationTypeCodeDescription",
		camdecmps.format_date_hour(mq.begin_date, null, null) AS "beginDate",
		camdecmps.format_date_hour(mq.end_date, null, null) AS "endDate",
		lme.qual_data_year AS "qualificationYear",
		lme.op_hours AS "operatingHours",
		lme.so2_tons AS "so2Tons",
		lme.nox_tons AS "noxTons"
	FROM camdecmps.monitor_qualification_lme lme
	JOIN camdecmps.monitor_qualification mq USING(mon_qual_id)
	JOIN camdecmps.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	JOIN camdecmpsmd.qual_type_code qtc USING(qual_type_cd)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
    LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, lme.qual_data_year;
$BODY$;
