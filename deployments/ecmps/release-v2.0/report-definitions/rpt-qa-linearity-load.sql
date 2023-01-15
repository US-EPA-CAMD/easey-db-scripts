DO $$
DECLARE
	datasetCode text := 'QA_LINE';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'DTLRPT', 'QA/Cert Test Detail Report', null);
----------------------------------------------------------------------------------------------------------------------
	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Linearity Check', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1, $2)', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'componentIdentifier', 'Component ID'),
		(datatableId, 2, 'componentTypeCode', 'Component Type'),
		(datatableId, 3, 'endDateTime', 'Test Completion'),
		(datatableId, 4, 'testNumber', 'Test Number'),
		(datatableId, 5, 'testReasonCode', 'Reason for Test'),
		(datatableId, 6, 'testResultCode', 'Reported Test Result'),
		(datatableId, 7, 'spanScaleCode', 'Span Scale Level'),
		(datatableId, 8, 'calcSpanValue', 'Span Value'),
		(datatableId, 9, 'calcTestResultCode', 'EPA Calculated Result');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	/***** DATATABLE 2 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 2, 'Protocol Gas', 'SELECT * FROM {SCHEMA}.rpt_qa_protocol_gas($1, $2)', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'gasLevelCode', 'Gas Level Code'),
		(datatableId, 2, 'gasTypeCode', 'Gas Type Code'),
		(datatableId, 3, 'vendorIdentifier', 'Vendor Identifier'),
		(datatableId, 4, 'cylinderIdentifier', 'Cylinder Identifier'),
		(datatableId, 5, 'expirationDate', 'Expiration Date');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	/***** DATATABLE 3 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 3, 'Summary Statistics', 'SELECT * FROM {SCHEMA}.rpt_qa_linearity_statistics($1, $2)', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'rowName', ''),
		(datatableId, 2, 'highReportedValue', 'High Reported'),
		(datatableId, 3, 'highCalculatedValue', 'High Calculated'),
		(datatableId, 4, 'midReportedValue', 'Mid Reported'),
		(datatableId, 5, 'midCalculatedValue', 'Mid Calculated'),
		(datatableId, 6, 'lowReportedValue', 'Low Reported'),
		(datatableId, 7, 'lowCalculatedValue', 'Low Calculated');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
/***** DATATABLE 4 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 4, 'Injection Statistics', 'SELECT * FROM {SCHEMA}.rpt_qa_linearity_injection($1, $2)', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'date', 'Date'),
		(datatableId, 2, 'gasLevelCode', 'Gas Level'),
		(datatableId, 3, 'measuredValue', 'Measured Value'),
		(datatableId, 4, 'referenceValue', 'Reference Value'),
		(datatableId, 5, 'refAsPercentOfSpan', 'Reference Value as % of Span');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'testId', null);
END $$;
