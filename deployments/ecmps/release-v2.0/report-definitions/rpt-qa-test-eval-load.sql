DO $$
DECLARE
	datasetCode text := 'TEST_EVAL';
	groupCode text := 'REPORT';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
	VALUES(datasetCode, groupCode, 'QA/Certification Tests Evaluation Report', 'Evaluation completed with no errors or informational messages.');
------------------------------------------------------------------------------------------------
	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement)
	VALUES(datasetCode, 1, 'Evaluation Results', 'SELECT * FROM camdecmpswks.rpt_qa_test_evaluation_results($1, $2, $3)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'testTypeCode', 'Test Type'),
		(datatableId, 3, 'testNumber', 'Test Number'),
		(datatableId, 4, 'beginPeriod', 'Begin Date/Hr/Min'),
		(datatableId, 5, 'endPeriod', 'End Date/Hr/Min'),
		(datatableId, 6, 'sysCompType', 'System Id / Component Id / System Type'),
		(datatableId, 7, 'severityCode', 'Severity'),
		(datatableId, 8, 'checkCode', 'Check Code'),
		(datatableId, 9, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'testId', null);
END $$;
