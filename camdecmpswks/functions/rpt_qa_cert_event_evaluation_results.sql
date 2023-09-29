-- FUNCTION: camdecmpswks.rpt_qa_cert_event_evaluation_results(text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_cert_event_evaluation_results(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_cert_event_evaluation_results(
	qacerteventid text)
    RETURNS TABLE("unitStack" text, "eventCode" text, "eventDateHour" text, "systemIdType" text, "componentIdType" text, "severityCode" text, "checkCode" text, "resultMessage" text) 
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
		qce.qa_cert_event_cd AS "eventCode",
		camdecmpswks.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, null) AS "eventDateHour",
		CASE
			WHEN ms.system_identifier IS NOT NULL THEN ms.system_identifier || '/' || ms.sys_type_cd
			ELSE null
		END AS "systemIdType",
		CASE
			WHEN c.component_identifier IS NOT NULL THEN c.component_identifier || '/' || c.component_type_cd
			ELSE null
		END AS "componentIdType",		
	    cl.severity_cd AS "severityCode",
    	cc.check_type_cd || '-' || cc.check_number || '-' || ccr.check_result AS "checkCode",
	    cl.result_message AS "resultMessage"
	FROM camdecmpswks.check_log cl
	JOIN camdecmpswks.check_session cs ON cl.chk_session_id = cs.chk_session_id
	JOIN camdecmpsmd.check_catalog_result ccr ON cl.check_catalog_result_id = ccr.check_catalog_result_id
	JOIN camdecmpsmd.check_catalog cc ON ccr.check_catalog_id = cc.check_catalog_id
	JOIN camdecmpsmd.rule_check rc ON cc.check_catalog_id = rc.check_catalog_id
	JOIN camdecmpswks.qa_cert_event qce ON cs.qa_cert_event_id = qce.qa_cert_event_id
	JOIN camdecmpswks.monitor_location ml ON cl.mon_loc_id = ml.mon_loc_id
	LEFT JOIN camdecmpswks.component c ON c.component_id = qce.component_id
	LEFT JOIN camdecmpswks.monitor_system ms ON ms.mon_sys_id = qce.mon_sys_id
	LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id = sp.stack_pipe_id
	LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
	WHERE rc.category_cd = 'EVENT' AND ((
		cs.batch_id IS NULL AND cs.qa_cert_event_id = qaCertEventId
	) OR (cs.batch_id IS NOT NULL AND cs.qa_cert_event_id IN (
		SELECT qa_cert_event_id FROM camdecmpswks.check_session WHERE batch_id = (
			SELECT batch_id FROM camdecmpswks.check_session WHERE qa_cert_event_id = qaCertEventId
		)
	)));
$BODY$;
