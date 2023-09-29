-- FUNCTION: camdecmpswks.rpt_qa_cert_event(text)

-- DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_cert_event(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_cert_event(
	qacerteventid text[])
    RETURNS TABLE("unitStack" text, "eventCode" text, "eventCodeGroup" text, "eventCodeDescription" text, "eventDateHour" text, "systemIdentifier" text, "systemTypeCode" text, "componentIdentifier" text, "componentTypeCode" text, "requiredTestCode" text, "requiredTestCodeGroup" text, "requiredTestCodeDescription" text, "conditionalBeginDateHour" text, "lastTestCompletedDateHour" text, "submissionStatus" text) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		qce.qa_cert_event_cd AS "eventCode",
		'Event Codes' AS "eventCodeGroup",
		qcec.qa_cert_event_cd_description AS "eventCodeDescription",
		camdecmps.format_date_hour(qce.qa_cert_event_date, qce.qa_cert_event_hour, null) AS "eventDateHour",
		ms.system_identifier AS "systemIdentifier",
		ms.sys_type_cd AS "systemTypeCode",
		c.component_identifier AS "componentIdentifier",
		c.component_type_cd AS "componentTypeCode",
		qce.required_test_cd AS "requiredTestCode",
		'Requied Test Codes' AS "requiredTestCodeGroup",
		rtc.required_test_cd_description AS "requiredTestCodeDescription",
		camdecmps.format_date_hour(qce.conditional_data_begin_date, qce.conditional_data_begin_hour, null) AS "conditionalBeginDateHour",
		camdecmps.format_date_hour(qce.last_test_completed_date, qce.last_test_completed_hour, null) AS "lastTestCompletedDateHour",
		qce.submission_availability_cd AS "submissionStatus"
	FROM camdecmps.qa_cert_event qce
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmps.monitor_system ms USING(mon_sys_id)
	LEFT JOIN camdecmps.component c USING(component_id)
	LEFT JOIN camdecmpsmd.qa_cert_event_code qcec USING(qa_cert_event_cd)
	LEFT JOIN camdecmpsmd.required_test_code rtc USING(required_test_cd)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE qce.qa_cert_event_id = ANY(qaCertEventId);
$BODY$;