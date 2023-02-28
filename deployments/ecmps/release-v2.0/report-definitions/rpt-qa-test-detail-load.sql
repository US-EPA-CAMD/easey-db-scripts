DO $$
DECLARE
	datasetCode text := 'TEST_DETAIL';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'QA/Cert Test Detail Report');
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FACINFO', 'SELECT * FROM {SCHEMA}.rpt_facility_information($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'facilityName', 'Facility Name'),
		(datatableId, 2, 'orisCode', 'Facility ID (ORISPL)'),
		(datatableId, 4, 'stateCode', 'State'),
		(datatableId, 5, 'countyName', 'County'),
		(datatableId, 6, 'latitude', 'Latitude'),
		(datatableId, 7, 'longitude', 'Longitude');
	
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'facilityId', null);
--------------------------------------------------------------------------------------------------------------------
-- LINEARITY CHECK
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'LINSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'LINGAS', 'SELECT * FROM {SCHEMA}.rpt_qa_protocol_gas($1)')
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
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'LINSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_linearity_statistics($1)')
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
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'LININJ', 'SELECT * FROM {SCHEMA}.rpt_qa_linearity_injection($1)')
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
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- CYCLE TIME TEST
--------------------------------------------------------------------------------------------------------------------
	tableOrder := 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'CYCSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_cycle_time_summary($1)')
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
		(datatableId, 9, 'calcTestResultCode', 'EPA Calculated Result'),
		(datatableId, 10, 'totalCycleTime', 'Total Cycle Time'),
		(datatableId, 11, 'calcTotalCycleTime', 'Calculated Total Cycle Time');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'CYCINJ', 'SELECT * FROM {SCHEMA}.rpt_qa_cycle_time_injection($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'date', 'Date'),
		(datatableId, 2, 'startTime', 'Start Time'),
		(datatableId, 3, 'endTime', 'End Time'),
		(datatableId, 4, 'gasLevelCode', 'Gas Level'),
		(datatableId, 5, 'gasValue', 'Reference Gas Value'),
		(datatableId, 6, 'beginMonitorValue', 'Starting Stable Value'),
		(datatableId, 7, 'endMonitorValue', 'Ending Stable Value'),
		(datatableId, 8, 'rptCycleTime', 'Reported Cycle Time'),
		(datatableId, 9, 'calcCycleTime', 'Calculated Cycle Time');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
END $$;
