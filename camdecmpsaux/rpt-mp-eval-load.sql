DO $$
DECLARE
	reportCode text := 'MP_EVAL';
	detailId integer;
BEGIN
	INSERT INTO camdecmpsaux.report(report_cd, report_title, report_template_cd, no_results_msg)
	VALUES(reportCode, 'Monitoring Plan Evaluation Report', 'SUMMARY', 'Evaluation complete with no errors or messages');

	/***** REPORT DETAIL 1 *****/
	INSERT INTO camdecmpsaux.report_detail(report_cd, sequence_number, detail_title, sql_statement, no_results_msg_override)
	VALUES(reportCode, 1, 'Evaluation Results', 'SELECT * FROM camdecmpswks.rpt_mp_evaluation_results($1)', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(1, 'unitStack', 'Unit/Stack', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(2, 'severityCode', 'Severity', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(3, 'category', 'Category', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(4, 'checkCode', 'Check Code', detailId);
	INSERT INTO camdecmpsaux.report_column(sequence_number, name, display_name, report_detail_id)
		VALUES(5, 'resultMessage', 'Result Message', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(sequence_number, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);
END $$;
