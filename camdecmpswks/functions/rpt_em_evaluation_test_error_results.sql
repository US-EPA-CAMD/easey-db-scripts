-- FUNCTION: camdecmpswks.rpt_em_evaluation_test_error_results(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_evaluation_test_error_results(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_evaluation_test_error_results(
	vMonPlanId text,
	vYear numeric,
	vQuarter numeric
)
RETURNS TABLE(
	"unitStack" text,
	"testTypeCode" text,
	"testDateTime" text,
	"sysCompId" text,
	"sysCompTypeScale" text,
	"severityCode" text,
	"checkCode" text,
	"resultMessage" text
)
LANGUAGE 'sql'
AS $BODY$
	SELECT DISTINCT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		dts.test_type_cd AS "testTypeCode",
		camdecmpswks.format_date_hour(dts.daily_test_date, dts.daily_test_hour, dts.daily_test_min) AS "testDateTime",
		COALESCE(c.component_identifier, '') AS "sysCompId",
		CASE
			WHEN c.component_type_cd IS NULL THEN ''
			ELSE c.component_type_cd || '/' || dts.span_scale_cd
		END AS "sysCompTypeScale",
		cl.severity_cd AS "severityCode",
		cc.check_type_cd || '-' || cc.check_number || '-' || ccr.check_result AS "checkCode",
		cl.result_message AS "resultMessage"
	FROM camdecmpswks.check_log cl
	JOIN camdecmpswks.check_session cs USING(chk_session_id)
	JOIN camdecmpsmd.reporting_period rp USING(rpt_period_id)
	JOIN camdecmpsmd.check_catalog_result ccr USING(check_catalog_result_id)
	JOIN camdecmpsmd.check_catalog cc ON ccr.check_catalog_id = cc.check_catalog_id
	JOIN camdecmpsmd.rule_check rc ON cc.check_catalog_id = rc.check_catalog_id
	JOIN camdecmpsmd.category_code ccd ON rc.category_cd = ccd.category_cd
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmpswks.daily_test_summary dts ON cl.test_sum_id = dts.daily_test_sum_id
	LEFT JOIN camdecmpswks.component c ON dts.component_id = c.component_id
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE cs.mon_plan_id = vMonPlanId AND rp.calendar_year = vYear AND rp.quarter = vQuarter AND
	ccd.process_cd = 'HOURLY' AND cc.check_type_cd IN ('DAYCAL', 'EMTEST', 'EMWTS', 'EMWSI');
$BODY$;
