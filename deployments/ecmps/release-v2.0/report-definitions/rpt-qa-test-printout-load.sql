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
	VALUES(datasetCode, tableOrder, 'FACINFO1C', 'SELECT * FROM {SCHEMA}.rpt_facility_information($1)')
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
-- HG LINEARITY CHECK
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'HGLINSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
	VALUES(datasetCode, tableOrder, 'HGLINSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_hg_linearity_statistics($1)')
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
	VALUES(datasetCode, tableOrder, 'HGLININJ', 'SELECT * FROM {SCHEMA}.rpt_qa_hg_linearity_injection($1)')
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

--------------------------------------------------------------------------------------------------------------------
-- TRANSMITTER TRANSDUCER
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FFACCTTSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 7, 'calcTestResultCode', 'EPA Calculated Result');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FFACCTTSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_trans_statistics($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'highLevelAccuracy', 'High Level Accuracy'),
		(datatableId, 2, 'highLevelAccuracySpec', 'High Level Accuracy Specification'),
		(datatableId, 3, 'midLevelAccuracy', 'Mid Level Accuracy'),
		(datatableId, 4, 'midLevelAccuracySpec', 'Mid Level Accuracy Specification'),
		(datatableId, 5, 'lowLevelAccuracy', 'Low Level Accuracy'),
		(datatableId, 6, 'lowLevelAccuracySpec', 'Low Level Accuracy Specification');
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- PEI
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'PEISUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'systemIdentifier', 'System ID'),
		(datatableId, 2, 'systemTypeCode', 'System Type'),
		(datatableId, 3, 'endDateTime', 'Test Completion'),
		(datatableId, 4, 'componentIdentifier', 'Component ID'),
		(datatableId, 5, 'componentTypeCode', 'Component Type'),
		(datatableId, 6, 'testResultCode', 'Reported Test Results'),
		(datatableId, 7, 'testNumber', 'Test Number'),
		(datatableId, 8, 'testReasonCode', 'Reason for Test'),
		(datatableId, 8, 'gpIndicator', 'Grace Period Test?');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- APPENDIX E NOX RATE
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'APPESUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'systemIdentifier', 'System ID'),
		(datatableId, 2, 'systemTypeCode', 'System Type'),
		(datatableId, 3, 'endDateTime', 'Test Completion'),
		(datatableId, 4, 'testNumber', 'Test Number'),
		(datatableId, 5, 'testReasonCode', 'Reason for Test'),
		(datatableId, 6, 'testResultCode', 'Reported Test Results');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'APPEGAS', 'SELECT * FROM {SCHEMA}.rpt_qa_protocol_gas($1)')
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
	VALUES(datasetCode, tableOrder, 'APPESTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_ae_statistics($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'operatingLevelNo', 'Operating Level No.'),
		(datatableId, 2, 'fFactor', 'F-Factor'),
		(datatableId, 3, 'reportedMeanNoxRate', 'Mean NOx Emission Rate'),
		(datatableId, 4, 'reportedAvgHiRate', 'Average Hourly Heat Input Rate'),
		(datatableId, 5, 'reportedCaclMeanNoxRate', 'Calculated Mean NOx Emission Rate'),
		(datatableId, 6, 'reportedCalcAvgHiRate', 'Calculated Average Hourly Heat Input Rate');
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'APPERUN', 'SELECT * FROM {SCHEMA}.rpt_qa_ae_run($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'operatingLevelNo', 'Operating Level No.'),
		(datatableId, 2, 'runNo', 'Run No.'),
		(datatableId, 3, 'beginDate', 'Begin Date/Hour'),
		(datatableId, 4, 'endDate', 'End Date/Hour'),
		(datatableId, 5, 'noxEmissionsRate', 'NOx Emission Rate'),
		(datatableId, 6, 'responseTime', 'Response Time (sec)'),
		(datatableId, 7, 'hourlyHiRate', 'Hourly HI Rate'),
		(datatableId, 8, 'totalHi', 'Total HI Rate'),
		(datatableId, 9, 'calculatedHourlyHiRate', 'Calculated Hourly HI Rate'),
		(datatableId, 10, 'calculatedTotalHi', 'Calculated Total HI Rate');
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'APPEOIL', 'SELECT * FROM {SCHEMA}.rpt_qa_ae_hi_oil($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'operatingLevelNo', 'Operating Level No.'),
		(datatableId, 2, 'runNo', 'Run No.'),
		(datatableId, 3, 'sysId', 'System ID'),
		(datatableId, 4, 'oilMass', 'Oil Mass (lb)'),
		(datatableId, 5, 'oilGCV', 'Oil GCV'),
		(datatableId, 6, 'oilGCVUOM', 'Oil GCV UOM'),
		(datatableId, 7, 'oilVolume', 'Oil Volume'),
		(datatableId, 8, 'oilVolumeUOM', 'Oil Volume UOM'),
		(datatableId, 9, 'oilDensity', 'Oil Density'),
		(datatableId, 10, 'oilDensityUOM', 'Oil Density UOM'),
		(datatableId, 11, 'oilHi', 'Oil HI'),
		(datatableId, 12, 'calculatedOilHI', 'Calculated Oil HI');
		
			/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
END $$;
