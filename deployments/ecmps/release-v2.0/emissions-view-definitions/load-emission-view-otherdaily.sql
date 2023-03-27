DO $$
DECLARE
	datasetCode text := 'OTHERDAILY';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Other Daily Tests View', 14, 'Other Daily Tests data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Other Daily Tests', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'test_type_cd', 'testTypeCode', 'Test Type'),
		(datatableId, 2, 'system_component_identifier', 'systemComponentIdentifier', 'System or Component ID'),
		(datatableId, 3, 'system_component_type', 'systemComponentType', 'System or Component Type'),
		(datatableId, 4, 'span_scale_cd', 'spanScaleCode', 'Span Scale'),
		(datatableId, 5, 'date_hour', 'dateHour', 'End Date/Time'),
		(datatableId, 7, 'rpt_test_result', 'rptTestResult', 'Test Result'),
		(datatableId, 8, 'calc_test_result_cd', 'calcTestResultCode', 'Calc Test Result'),
		(datatableId, 9, 'error_codes', 'errorCodes', 'Daily Errors');
END $$;