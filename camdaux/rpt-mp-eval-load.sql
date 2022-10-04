DO $$
DECLARE
	datasetCode text := 'MP_EVAL';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'Summary Report', 'Monitoring Plan Evaluation Report', 'Evaluation completed with no errors or informational messages.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Evaluation Results', 'SELECT * FROM camdecmpswks.rpt_mp_evaluation_results($1)', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'severityCode', 'Severity'),
		(datatableId, 3, 'category', 'Category'),
		(datatableId, 4, 'checkCode', 'Check Code'),
		(datatableId, 5, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.datatable_parameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
END $$;
