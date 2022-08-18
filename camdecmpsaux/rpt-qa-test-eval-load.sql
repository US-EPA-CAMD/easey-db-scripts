DO $$
DECLARE
	reportType text := 'TEST_EVAL';
	reportId integer;
	detailId integer;
BEGIN
	INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES(reportType, 'QA/Certification Tests Evaluation Report', 'Evaluation complete with no errors or messages')
	RETURNING report_id INTO reportId;

	/***** REPORT DETAIL 1 *****/
	INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES(reportId, position, 'Evaluation Results', 'SELECT * FROM camdecmpswks.rpt_qa_test_evaluation_results($1, $2, $3)', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(1, 'unitStack', 'Unit/Stack', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(2, 'testTypeCode', 'Test Type', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(3, 'testNumber', 'Test Number', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(4, 'beginPeriod', 'Begin Date/Hr/Min', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(5, 'endPeriod', 'End Date/Hr/Min', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(6, 'sysCompType', 'System Id / Component Id / System Type', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(7, 'severityCode', 'Severity', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(8, 'checkCode', 'Check Code', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(9, 'resultMessage', 'Result Message', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);
	INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
		VALUES(2, 'testId', null, detailId);
	INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
		VALUES(3, 'batchView', false, detailId);
END $$;
