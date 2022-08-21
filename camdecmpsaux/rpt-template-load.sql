DO $$
DECLARE
	reportCode text = '';
	detailId integer;
BEGIN
	INSERT INTO camdecmpsaux.report(report_cd, report_title, report_template_cd, no_results_msg)
	VALUES(reportCode, '', '', '');

	/***** REPORT DETAIL 1 *****/
	INSERT INTO camdecmpsaux.report_detail(report_cd, sequence_number, title, sql_statement, no_results_msg_override)
	VALUES(reportCode, sequence_number, '', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(1, '', '', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(sequence_number, name, default_value, report_detail_id)
		VALUES(1, '', '', detailId);

/*
reportCode := 'QCE_EVAL';
VALUES(reportCode, 'QA/Certification Events Evaluation Report', 'Evaluation complete with no errors or messages');
sequence_number := 1
VALUES(reportCode, sequence_number, 'Evaluation Results', null);

reportCode := 'TEE_EVAL';
VALUES(reportCode, 'Test Extensions/Exemptions Evaluation Report', 'Evaluation complete with no errors or messages');
sequence_number := 1
VALUES(reportCode, sequence_number, 'Evaluation Results', null);

reportCode := 'EM_EVAL';
VALUES(reportCode, 'Emissions Evaluation Report', 'Evaluation complete with no errors or messages');
sequence_number := 1
VALUES(reportCode, sequence_number, 'General Errors', null);
sequence_number := 2
VALUES(reportCode, sequence_number, 'Test Data Errors', null);
sequence_number := 3
VALUES(reportCode, sequence_number, 'Hourly Data Errors', null);
sequence_number := 4
VALUES(reportCode, sequence_number, 'Summary Data Errors', null);
*/

END $$;