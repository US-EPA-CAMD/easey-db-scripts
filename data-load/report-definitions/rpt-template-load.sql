DO $$
DECLARE
	datasetCode text := '';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'template_cd', 'display_name', 'no_results_msg');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'display_name', 'sql_statement', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, '', ''),
		(datatableId, 2, '', ''),
		(datatableId, 3, '', '');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.datatable_parameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, '', null),
		(datatableId, 2, '', null);

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