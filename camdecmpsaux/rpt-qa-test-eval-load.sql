DO $$
DECLARE
	reportCode text := 'TEST_EVAL';
	detailId integer;
BEGIN
	INSERT INTO camdecmpsaux.report(report_cd, report_title, report_template_cd, no_results_msg)
	VALUES(reportCode, 'QA/Certification Tests Evaluation Report', 'SUMMARY', 'Evaluation complete with no errors or messages');

	/***** REPORT DETAIL 1 *****/
	INSERT INTO camdecmpsaux.report_detail(report_cd, sequence_number, detail_title, sql_statement, no_results_msg_override)
	VALUES(reportCode, 1, 'Evaluation Results', 'SELECT * FROM camdecmpswks.rpt_qa_test_evaluation_results($1, $2, $3)', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(1, 'unitStack', 'Unit/Stack', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(2, 'testTypeCode', 'Test Type', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(3, 'testNumber', 'Test Number', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(4, 'beginPeriod', 'Begin Date/Hr/Min', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(5, 'endPeriod', 'End Date/Hr/Min', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(6, 'sysCompType', 'System Id / Component Id / System Type', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(7, 'severityCode', 'Severity', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(8, 'checkCode', 'Check Code', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(9, 'resultMessage', 'Result Message', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(sequence_number, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);
	INSERT INTO camdecmpsaux.report_parameter(sequence_number, name, default_value, report_detail_id)
		VALUES(2, 'testId', null, detailId);
	INSERT INTO camdecmpsaux.report_parameter(sequence_number, name, default_value, report_detail_id)
		VALUES(3, 'batchView', false, detailId);
END $$;
