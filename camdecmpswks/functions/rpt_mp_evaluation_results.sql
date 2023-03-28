-- FUNCTION: camdecmpswks.rpt_mp_evaluation_results(text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_mp_evaluation_results(text);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_evaluation_results(
	monplanid text)
    RETURNS TABLE("unitStack" text, "severityCode" text, "categoryDescription" text, "checkCode" text, "resultMessage" text) 
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
		cl.severity_cd AS "severityCode",
		LTRIM(TRIM(leading '-' from ccd.category_cd_description)) AS "categoryDescription",
		cc.check_type_cd || '-' || cc.check_number || '-' || ccr.check_result AS "checkCode",
		cl.result_message AS "resultMessage"
	FROM camdecmpswks.check_log cl
	JOIN camdecmpswks.check_session cs ON cl.chk_session_id = cs.chk_session_id
	JOIN camdecmpsmd.check_catalog_result ccr ON cl.check_catalog_result_id = ccr.check_catalog_result_id
	JOIN camdecmpsmd.check_catalog cc ON ccr.check_catalog_id = cc.check_catalog_id
	JOIN camdecmpsmd.rule_check rc ON cc.check_catalog_id = rc.check_catalog_id
	JOIN camdecmpsmd.category_code ccd ON rc.category_cd = ccd.category_cd
	JOIN camdecmpswks.monitor_location ml ON cl.mon_loc_id = ml.mon_loc_id
	LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id = sp.stack_pipe_id
	LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
	WHERE ccd.process_cd = 'MP' AND cs.mon_plan_id = monPlanId;
$BODY$;
