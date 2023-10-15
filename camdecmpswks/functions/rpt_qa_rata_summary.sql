-- FUNCTION: camdecmps.rpt_qa_test_summary(text)

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_rata_summary(
	testsumid text)
    RETURNS TABLE(
		"unitStack" text, "gpIndicator" numeric, "testTypeCode" text, "testNumber" text, "testReasonCode" text, "testResultCode" text, "calcTestResultCode" text, "spanScaleCode" text, "calcSpanValue" numeric, "beginDateTime" text ,"endDateTime" text, "systemIdentifier" text, "systemTypeCode" text, "componentIdentifier" text, "componentTypeCode" text, "quarter" text, "evalStatus" text, "submissionStatus" text, "submittedOn" text, "testDescription" text,
		"noLoad" numeric,
		"biasAdjFactor" numeric,
		"calcBiasAdjFactor" numeric,
		"freqCd" text) 
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
		ts.gp_ind as "gpIndicator",
		ts.test_type_cd AS "testTypeCode",
		ts.test_num AS "testNumber",
		ts.test_reason_cd AS "testReasonCode",
		ts.test_result_cd AS "testResultCode",
		ts.calc_test_result_cd AS "calcTestResultCode",	
		ts.span_scale_cd AS "spanScaleCode",
		ts.calc_span_value AS "calcSpanValue",
		camdecmpswks.format_date_hour(ts.begin_date, ts.begin_hour, ts.begin_min) AS "beginDateTime",
		camdecmpswks.format_date_hour(ts.end_date, ts.end_hour, ts.end_min) AS "endDateTime",
		ms.system_identifier AS "systemIdentifier",
		ms.sys_type_cd AS "systemTypeCode",
		c.component_identifier AS "componentIdentifier",
		c.component_type_cd AS "componentTypeCode",
		rp.period_abbreviation as "quarter",
		esc.eval_status_cd_description as "evalStatus",
		sac.sub_avail_cd_description as "submisionStatus",
		TO_CHAR(eq.submitted_on, 'MM/DD/YYYY HH24:MI') as "submittedOn",
		ts.test_description as "testDescription",
		r.num_load_level as "noLoad",
		r.overall_bias_adj_factor as "biasAdjFactor",
		r.calc_overall_bias_adj_factor as "calcBiasAdjFactor",
		r.rata_frequency_cd as "freqCd"
	FROM camdecmpswks.test_summary ts
	JOIN camdecmpswks.rata r on r.test_sum_id = ts.test_sum_id 
	JOIN camdecmpswks.qa_supp_data supp on ts.test_sum_id = supp.test_sum_id
	JOIN camdecmpswks.monitor_location ml ON ts.mon_loc_id = ml.mon_loc_id
	JOIN camdecmpsmd.eval_status_code esc USING(eval_status_cd)
	JOIN camdecmpsmd.submission_availability_code sac USING(submission_availability_cd)
	LEFT JOIN camdecmpsaux.submission_queue eq using(submission_id)
	LEFT JOIN camdecmpsmd.reporting_period rp on rp.rpt_period_id = ts.rpt_period_id
	LEFT JOIN camdecmpswks.monitor_system ms on ms.mon_sys_id = ts.mon_sys_id
	LEFT JOIN camdecmpswks.component c on c.component_id = ts.component_id
	LEFT JOIN camdecmpswks.stack_pipe sp on sp.stack_pipe_id = ml.stack_pipe_id
	LEFT JOIN camd.unit u on u.unit_id = ml.unit_id
	WHERE ts.test_sum_id = testSumId;
$BODY$;