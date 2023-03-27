DO $$
DECLARE
	datasetCode text := 'MATSWEEKLY';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'MATS weekly View', 19, 'MATS weekly data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'MATS weekly', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'system_component_identifier', 'systemComponentIdentifier', 'Component ID'),
		(datatableId, 2, 'system_component_type', 'systemComponentType', 'Component Type'),
		(datatableId, 3, 'date_hour', 'dateHour', 'Test Date'),
		(datatableId, 4, 'test_type', 'testType', 'Test Type'),
		(datatableId, 5, 'test_result', 'testResult', 'Test Result'),
		(datatableId, 6, 'span_scale', 'spanScale', 'Span Scale'),
		(datatableId, 7, 'gas_level', 'gasLevel', 'Gas Level'),
		(datatableId, 8, 'ref_value', 'referenceValue', 'Ref Value'),
		(datatableId, 9, 'measured_value', 'measuredValue', 'Measured Value'),
		(datatableId, 10, 'system_integrity_error', 'systemIntegrityError', 'System Integrity Error'),
		(datatableId, 11, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;