-- FUNCTION: camdecmpswks.rpt_qa_test_evaluation_results(character varying, character varying, boolean)

-- DROP FUNCTION camdecmpswks.rpt_qa_test_evaluation_results(character varying, character varying, boolean);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_test_evaluation_results(
	monplanid character varying,
	testsumid character varying,
	batchview boolean)
    RETURNS TABLE("unitStack" character varying, "testTypeCode" character varying, "testNumber" character varying, "beginPeriod" text, "endPeriod" text, "sysCompType" text, "severityCode" character varying, category character varying, "checkCode" text, "resultMessage" character varying) 
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
		ts.test_type_cd AS "testTypeCode",
		ts.test_num AS "testNumber",
		ts.begin_date || ' ' || ts.begin_hour || ':' || ts.begin_min AS "beginPeriod",
		ts.end_date || ' ' || ts.end_hour || ':' || ts.end_min AS "endPeriod",
		CASE
			WHEN ms.system_identifier IS NOT NULL THEN ms.system_identifier || '/' || ms.sys_type_cd
			WHEN c.component_identifier IS NOT NULL THEN c.component_identifier || '/' || c.component_type_cd
			ELSE null
		END AS "sysCompType",
	    cl.severity_cd AS "severityCode",
    	ccd.category_cd_description AS "category",
    	cc.check_type_cd || '-' || cc.check_number || '-' || ccr.check_result AS "checkCode",
	    cl.result_message AS "resultMessage"
	FROM camdecmpswks.check_log cl
	 JOIN camdecmpswks.check_session cs ON cl.chk_session_id = cs.chk_session_id
     JOIN camdecmpsmd.check_catalog_result ccr ON cl.check_catalog_result_id = ccr.check_catalog_result_id
     JOIN camdecmpsmd.check_catalog cc ON ccr.check_catalog_id = cc.check_catalog_id
     JOIN camdecmpsmd.rule_check rc ON cc.check_catalog_id = rc.check_catalog_id
     JOIN camdecmpsmd.category_code ccd ON rc.category_cd = ccd.category_cd AND ccd.process_cd = 'TEST'
	 LEFT JOIN camdecmpswks.test_summary ts ON cs.test_sum_id = ts.test_sum_id
	 LEFT JOIN camdecmpswks.component c ON c.component_id = ts.component_id
	 LEFT JOIN camdecmpswks.monitor_system ms ON ms.mon_sys_id = ts.mon_sys_id
     LEFT JOIN camdecmpswks.monitor_location ml ON cl.mon_loc_id = ml.mon_loc_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id = sp.stack_pipe_id
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
	WHERE
	  (cs.mon_plan_id = monPlanId AND batchView = true AND cs.batch_id IS NOT NULL) OR
	  (cs.mon_plan_id = monPlanId AND batchView = false AND testSumId IS NULL) OR	
	  (cs.mon_plan_id = monPlanId AND batchView = false AND testSumId IS NOT NULL AND cs.test_sum_id = testSumId);
$BODY$;
