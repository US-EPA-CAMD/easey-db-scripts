DO $$
DECLARE
	reportType text := 'MP_EVAL';
	reportId integer;
	detailId integer;
BEGIN
	INSERT INTO camdecmpsaux.report(report_type_cd, report_title, no_results_msg)
	VALUES(reportType, 'Monitoring Plan Evaluation Report', 'Evaluation complete with no errors or messages')
	RETURNING report_id INTO reportId;

	/***** REPORT DETAIL 1 *****/
	INSERT INTO camdecmpsaux.report_detail(report_id, position, title, sql_statement, no_results_msg_override)
	VALUES(reportId, 1, 'Evaluation Results', 'SELECT * FROM camdecmpswks.rpt_mp_evaluation_results($1)', null)
	RETURNING report_detail_id INTO detailId;

	/***** COLUMNS *****/
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(1, 'unitStack', 'Unit/Stack', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(2, 'severityCode', 'Severity', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(3, 'category', 'Category', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(4, 'checkCode', 'Check Code', detailId);
	INSERT INTO camdecmpsaux.report_column(position, name, display_name, report_detail_id)
		VALUES(5, 'resultMessage', 'Result Message', detailId);

	/***** PARAMETERS *****/
	INSERT INTO camdecmpsaux.report_parameter(position, name, default_value, report_detail_id)
		VALUES(1, 'monitorPlanId', null, detailId);
END $$;
