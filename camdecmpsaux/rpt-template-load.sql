DO $$
DECLARE
	reportType text = '';
	reportId integer;
	detailId integer;
BEGIN
	INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES(reportType, '', '')
	RETURNING report_id INTO reportId;

	/***** REPORT DETAIL 1 *****/
	INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES(reportId, position, '', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(1, '', '', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
		VALUES(1, '', '', detailId);

/*
reportType := 'QCE_EVAL';
VALUES(reportType, 'QA/Certification Events Evaluation Report', 'Evaluation complete with no errors or messages');
position := 1
VALUES(reportId, position, 'Evaluation Results', null);

reportType := 'TEE_EVAL';
VALUES(reportType, 'Test Extensions/Exemptions Evaluation Report', 'Evaluation complete with no errors or messages');
position := 1
VALUES(reportId, position, 'Evaluation Results', null);

reportType := 'EM_EVAL';
VALUES(reportType, 'Emissions Evaluation Report', 'Evaluation complete with no errors or messages');
position := 1
VALUES(reportId, position, 'General Errors', null);
position := 2
VALUES(reportId, position, 'Test Data Errors', null);
position := 3
VALUES(reportId, position, 'Hourly Data Errors', null);
position := 4
VALUES(reportId, position, 'Summary Data Errors', null);
*/

END $$;