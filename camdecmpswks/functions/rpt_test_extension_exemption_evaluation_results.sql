-- FUNCTION: camdecmpswks.rpt_test_extension_exemption_evaluation_results(text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_test_extension_exemption_evaluation_results(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_test_extension_exemption_evaluation_results(
	testextensionexemptionid text)
    RETURNS TABLE("unitStack" text, "extensionExemptionCode" text, "yearQuarter" text, "systemIdType" text, "componentIdType" text, "severityCode" text, "categoryDescription" text, "checkCode" text, "resultMessage" text) 
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
		tee.extens_exempt_cd AS "extensionExemptionCode",
    rp.period_abbreviation AS "yearQuarter",
		CASE
			WHEN ms.system_identifier IS NOT NULL THEN ms.system_identifier || '/' || ms.sys_type_cd
			ELSE null
		END AS "systemIdType",
		CASE
			WHEN c.component_identifier IS NOT NULL THEN c.component_identifier || '/' || c.component_type_cd
			ELSE null
		END AS "componentIdType",
	    cl.severity_cd AS "severityCode",
    	LTRIM(TRIM(leading '-' from ccd.category_cd_description)) AS "categoryDescription",
    	cc.check_type_cd || '-' || cc.check_number || '-' || ccr.check_result AS "checkCode",
	    cl.result_message AS "resultMessage"
	FROM camdecmpswks.check_log cl
	JOIN camdecmpswks.check_session cs ON cl.chk_session_id = cs.chk_session_id
	JOIN camdecmpsmd.check_catalog_result ccr ON cl.check_catalog_result_id = ccr.check_catalog_result_id
	JOIN camdecmpsmd.check_catalog cc ON ccr.check_catalog_id = cc.check_catalog_id
	JOIN camdecmpsmd.rule_check rc ON cl.rule_check_id = rc.rule_check_id
	JOIN camdecmpsmd.category_code ccd ON rc.category_cd = ccd.category_cd
	JOIN camdecmpswks.test_extension_exemption tee ON cs.test_extension_exemption_id = tee.test_extension_exemption_id
	JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = tee.rpt_period_id
	LEFT JOIN camdecmpswks.monitor_location ml ON cl.mon_loc_id = ml.mon_loc_id
	LEFT JOIN camdecmpswks.component c ON c.component_id = tee.component_id
	LEFT JOIN camdecmpswks.monitor_system ms ON ms.mon_sys_id = tee.mon_sys_id
	LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id = sp.stack_pipe_id
	LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
	WHERE cl.severity_cd <> 'NONE' AND rc.category_cd = 'TEE' AND ((
		cs.batch_id IS NULL AND cs.test_extension_exemption_id = testExtensionExemptionId
	) OR (cs.batch_id IS NOT NULL AND cs.test_extension_exemption_id IN (
		SELECT test_extension_exemption_id FROM camdecmpswks.check_session WHERE batch_id = (
			SELECT batch_id FROM camdecmpswks.check_session WHERE test_extension_exemption_id = testExtensionExemptionId
		)
	)));
$BODY$;