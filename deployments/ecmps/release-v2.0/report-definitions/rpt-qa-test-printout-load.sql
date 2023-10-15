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
		(datatableId, 9, 'calcTestResultCode', 'EPA Calculated Result'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'gpIndicator', 'Grace period Tested?'),
		(datatableId, 17, 'hidden5', 'HIDDEN'),
		(datatableId, 18, 'submittedOn', 'Submission Date/Time');

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
		(datatableId, 9, 'calcTestResultCode', 'EPA Calculated Result'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'gpIndicator', 'Grace period Tested?'),
		(datatableId, 17, 'hidden5', 'HIDDEN'),
		(datatableId, 18, 'submittedOn', 'Submission Date/Time');

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
		(datatableId, 11, 'calcTotalCycleTime', 'Calculated Total Cycle Time'),
		(datatableId, 12, 'hidden1', 'HIDDEN'),
		(datatableId, 13, 'hidden2', 'HIDDEN'),
		(datatableId, 14, 'hidden3', 'HIDDEN'),
		(datatableId, 15, 'hidden4', 'HIDDEN'),
		(datatableId, 16, 'evalStatus', 'Evaluation Status'),
		(datatableId, 17, 'hidden5', 'HIDDEN'),
		(datatableId, 18, 'submissionStatus', 'Submission Status'),
		(datatableId, 19, 'hidden6', 'HIDDEN'),
		(datatableId, 20, 'hidden7', 'HIDDEN'),
		(datatableId, 21, 'submittedOn', 'Submission Date/Time');

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
		(datatableId, 7, 'hidden1', 'HIDDEN'),
		(datatableId, 8, 'hidden2', 'HIDDEN'),
		(datatableId, 9, 'calcTestResultCode', 'EPA Calculated Result'),
		(datatableId, 10, 'hidden3', 'HIDDEN'),
		(datatableId, 11, 'hidden4', 'HIDDEN'),
		(datatableId, 12, 'hidden5', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden6', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'hidden7', 'HIDDEN'),
		(datatableId, 17, 'hidden8', 'HIDDEN'),
		(datatableId, 18, 'submittedOn', 'Submission Date/Time');


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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'testDescription', 'Test Description');

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
		(datatableId, 6, 'testResultCode', 'Reported Test Results'),
		(datatableId, 7, 'hidden1', 'HIDDEN'),
		(datatableId, 8, 'hidden2', 'HIDDEN'),
		(datatableId, 9, 'hidden3', 'HIDDEN'),
		(datatableId, 10, 'evalStatus', 'Evaluation Status'),
		(datatableId, 11, 'hidden6', 'HIDDEN'),
		(datatableId, 12, 'submissionStatus', 'Submission Status'),
		(datatableId, 13, 'hidden7', 'HIDDEN'),
		(datatableId, 14, 'hidden8', 'HIDDEN'),
		(datatableId, 15, 'submittedOn', 'Submission Date/Time');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'APPETEST', 'SELECT * FROM {SCHEMA}.rpt_qa_ae_testing($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'qIName', 'QI Name'),
		(datatableId, 2, 'hidden1', 'HIDDEN'),
		(datatableId, 3, 'aetbName', 'AETB Name'),
		(datatableId, 5, 'examDate', 'Exam Date'),
		(datatableId, 6, 'hidden3', 'HIDDEN'),
		(datatableId, 7, 'aetbPhone', 'AETB Phone Number'),
		(datatableId, 9, 'providerName', 'Provider Name'),
		(datatableId, 10, 'hidden5', 'HIDDEN'),
		(datatableId, 11, 'aetbEmail', 'AETB Email'),
		(datatableId, 13, 'providerEmail', 'Provider Email');

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
	VALUES(datasetCode, tableOrder, 'APPEHIOIL', 'SELECT * FROM {SCHEMA}.rpt_qa_ae_hi_oil($1)')
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
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'APPEHIGAS', 'SELECT * FROM {SCHEMA}.rpt_qa_ae_hi_gas($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'operatingLevelNo', 'Operating Level No.'),
		(datatableId, 2, 'runNo', 'Run No.'),
		(datatableId, 3, 'sysId', 'System ID'),
		(datatableId, 4, 'gasGCV', 'Oil Mass (lb)'),
		(datatableId, 5, 'gasVolume', 'Oil GCV'),
		(datatableId, 6, 'gasHI', 'Oil GCV UOM'),
		(datatableId, 7, 'calculatedGasHI', 'Oil Volume');		
			/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- BAROMETER CALIBRATION
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'BCALSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- FLOW TO LOAD REF
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'F2LREFSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'systemIdentifier', 'System ID'),
		(datatableId, 2, 'systemTypeCode', 'System Type'),
		(datatableId, 3, 'endDateTime', 'Test Completion'),
		(datatableId, 4, 'testNumber', 'Test Number'),
		(datatableId, 5, 'hidden1', 'HIDDEN'),
		(datatableId, 5, 'hidden2', 'HIDDEN'),
		(datatableId, 6, 'hidden3', 'HIDDEN'),
		(datatableId, 7, 'hidden4', 'HIDDEN'),
		(datatableId, 8, 'hidden5', 'HIDDEN'),
		(datatableId, 9, 'evalStatus', 'Evaluation Status'),
		(datatableId, 10, 'hidden6', 'HIDDEN'),
		(datatableId, 11, 'submissionStatus', 'Submission Status'),
		(datatableId, 12, 'hidden7', 'HIDDEN'),
		(datatableId, 13, 'hidden8', 'HIDDEN'),
		(datatableId, 14, 'submittedOn', 'Submission Date/Time');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'F2LREFSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_fl2ref($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'rataTestNumRef', 'Reference RATA Test Number'),
		(datatableId, 2, 'refRataEndDate', 'Reference RATA End Date'),
		(datatableId, 3, 'averageGrossUnitLoad', 'Average Gross Load'),
		(datatableId, 4, 'opLevelCode', 'Operating Level'),
		(datatableId, 5, 'avgRefFlowRate', 'Average Reference Flow Rate (scfh)'),
		(datatableId, 6, 'refFlowLoadRatio', 'Reference Flow/Load Ratio'),
		(datatableId, 7, 'avgHrlyHiRate', 'Average Hourly HI Rate (mmBtu/hr)'),
		(datatableId, 8, 'refGHR', 'Reference Gross Heat Rate'),
		(datatableId, 9, 'sepRefInd', 'Separate Reference Ratio Indicator');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- FLOW TO LOAD RATIO OR REF
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'F2LCHKSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'systemIdentifier', 'System ID'),
		(datatableId, 2, 'systemTypeCode', 'System Type'),
		(datatableId, 3, 'quarter', 'Calendar Year/Quarter'),
		(datatableId, 4, 'testNumber', 'Test Number'),
		(datatableId, 5, 'testReasonCode', 'Reason for Test'),		
		(datatableId, 6, 'testResultCode', 'Reported Test Results'),
		(datatableId, 7, 'hidden1', 'HIDDEN'),
		(datatableId, 8, 'hidden2', 'HIDDEN'),
		(datatableId, 9, 'calcTestResultCode', 'EPA Calculated Result'),
		(datatableId, 10, 'hidden3', 'HIDDEN'),
		(datatableId, 11, 'hidden4', 'HIDDEN'),
		(datatableId, 12, 'hidden5', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden6', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'hidden7', 'HIDDEN'),
		(datatableId, 17, 'hidden8', 'HIDDEN'),
		(datatableId, 18, 'submittedOn', 'Submission Date/Time');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'F2LCHKSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_fl2chk($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'opLevel', 'Operating Level'),
		(datatableId, 2, 'testBasis', 'Test Basis'),
		(datatableId, 3, 'pctDiff', '% Difference Between Reference Ratio and Hourly Ratio'),
		(datatableId, 4, 'adjFlowInd', 'Bias Adjusted Flow Ind.'),
		(datatableId, 5, 'hoursUsed', 'Hours Used in Quarterly Analysis'),
		(datatableId, 6, 'diffFuel', 'Hours Excluded for Different Fuel'),
		(datatableId, 7, 'loadRamping', 'Hours Excluded for Load Ramping'),
		(datatableId, 8, 'scrubberBypass', 'Hours Excluded for Scrubber Bypass'),
		(datatableId, 9, 'preFlowRata', 'Hours Excluded for Preceeding Flow RATA'),
		(datatableId, 8, 'preDiagTest', 'Hours Excluded for Preceeding Diagnostic Test'),
		(datatableId, 8, 'multiStackDischarge', 'Hours Excluded for Multiple Stack Discharge');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- FUEL FLOW TO LOAD BASELINE
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FF2LBASSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_ffl2bas_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'systemIdentifier', 'System ID'),
		(datatableId, 2, 'systemTypeCode', 'System Type'),
		(datatableId, 3, 'beginDateTime', 'Test Initiation'),
		(datatableId, 4, 'testNumber', 'Test Number'),
		(datatableId, 5, 'hidden1', 'HIDDEN'),
		(datatableId, 6, 'endDateTime', 'Test Completion'),
		(datatableId, 7, 'accTestNum', 'Accuracy Test Number'),
		(datatableId, 8, 'peiTestNum', 'PEI Test Number'),
		(datatableId, 9, 'hidden2', 'HIDDEN'),
		(datatableId, 10, 'hidden3', 'HIDDEN'),
		(datatableId, 11, 'hidden4', 'HIDDEN'),
		(datatableId, 12, 'hidden5', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden6', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'hidden7', 'HIDDEN'),
		(datatableId, 17, 'hidden8', 'HIDDEN'),
		(datatableId, 18, 'submittedOn', 'Submission Date/Time');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FF2LBASSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_ffl2bas($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'avgFlowRate', 'Avg. Fuel Flow Rate'),
		(datatableId, 2, 'avgGrossLoad', 'Avg. Gross Unit Load'),
		(datatableId, 3, 'baseRatio', 'Baseline Fuel Flow-to-Load Ratio'),
		(datatableId, 4, 'UOM', 'Fuel Flow-to-Load Units of Measure'),
		(datatableId, 5, 'avgHHIP', 'Avg. Hourly Heat Input Rate'),
		(datatableId, 6, 'baseGrossHeat', 'Baseline Gross Heat Rate'),
		(datatableId, 7, 'ghrUOM', 'GHR Units of Measure'),
		(datatableId, 8, 'hoursExcludedCo', 'Hours Excluded for Co-Firing'),
		(datatableId, 9, 'hoursExcludedRamp', 'Hours Excluded for Ramping'),
		(datatableId, 8, 'hoursExcludedRange', 'Hours Excluded for Low Range');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- FUEL FLOW TO LOAD TEST
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FF2LTSTSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'systemIdentifier', 'System ID'),
		(datatableId, 2, 'systemTypeCode', 'System Type'),
		(datatableId, 3, 'quarter', 'Calendar Year/Quarter'),
		(datatableId, 4, 'testNumber', 'Test Number'),
		(datatableId, 5, 'testReasonCode', 'Reason for Test'),		
		(datatableId, 6, 'testResultCode', 'Reported Test Results'),
		(datatableId, 7, 'hidden1', 'HIDDEN'),
		(datatableId, 8, 'hidden2', 'HIDDEN'),
		(datatableId, 9, 'hidden3', 'HIDDEN'),
		(datatableId, 10, 'evalStatus', 'Evaluation Status'),
		(datatableId, 11, 'hidden4', 'HIDDEN'),
		(datatableId, 12, 'submissionStatus', 'Submission Status'),
		(datatableId, 13, 'hidden5', 'HIDDEN'),
		(datatableId, 14, 'hidden6', 'HIDDEN'),
		(datatableId, 15, 'submittedOn', 'Submission Date/Time');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FF2LTSTSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_ff2ltst($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'testBasis', 'Test Basis'),
		(datatableId, 2, 'avgPctDiff', 'Avg. Absolute Percent Difference'),
		(datatableId, 3, 'hoursUsed', 'Hours Used in Analysis'),
		(datatableId, 4, 'coFire', 'Hours Excluded for Co-Firing'),
		(datatableId, 5, 'ramping', 'Hours Excluded for Ramping'),
		(datatableId, 6, 'lowRange', 'Hours Excluded for Low Range');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- FUEL FLOWMETER ACCURACY
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FFACCSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'componentIdentifier', 'Component ID'),
		(datatableId, 2, 'componentTypeCode', 'Component Type'),
		(datatableId, 3, 'endDateTime', 'Test Completion'),
		(datatableId, 4, 'testNumber', 'Test Number'),
		(datatableId, 5, 'hidden1', 'HIDDEN'),
		(datatableId, 6, 'testResultCode', 'Reported Test Results'),
		(datatableId, 7, 'hidden2', 'HIDDEN'),
		(datatableId, 8, 'hidden3', 'HIDDEN'),
		(datatableId, 9, 'calcTestResultCode', 'EPA Calculated Result'),
		(datatableId, 10, 'hidden4', 'HIDDEN'),
		(datatableId, 11, 'hidden5', 'HIDDEN'),
		(datatableId, 12, 'hidden6', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden7', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'hidden8', 'HIDDEN'),
		(datatableId, 17, 'hidden9', 'HIDDEN'),
		(datatableId, 18, 'submittedOn', 'Submission Date/Time');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FFACCSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_ffacc($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'accMethod', 'Accuracy Test Method'),
		(datatableId, 2, 'highAcc', 'High Level Accuracy'),
		(datatableId, 3, 'midAcc', 'Mid Level Accuracy'),
		(datatableId, 4, 'lowAcc', 'Low Level Accuracy'),
		(datatableId, 5, 'reinstall', 'Reinstallation Date/Hour');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- HGSI3 LINEARITY CHECK
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'HGSI3SUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'gpIndicator', 'Grace period Tested?'),
		(datatableId, 17, 'hidden5', 'HIDDEN'),
		(datatableId, 18, 'submittedOn', 'Submission Date/Time');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'HGSI3STAT', 'SELECT * FROM {SCHEMA}.rpt_qa_hg_linearity_statistics($1)')
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
	VALUES(datasetCode, tableOrder, 'HGSI3INJ', 'SELECT * FROM {SCHEMA}.rpt_qa_hg_linearity_injection($1)')
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
-- On-Line/Off-Line Calibration
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'ONOFFSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 16, 'hidden5', 'HIDDEN'),
		(datatableId, 17, 'hidden6', 'HIDDEN'),
		(datatableId, 18, 'submittedOn', 'Submission Date/Time');



	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'ONOFFSTAT', 'SELECT * FROM {SCHEMA}.get_on_off_cal_statistic($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'calType', 'Calibration Type'),
		(datatableId, 2, 'injectionDateHour', 'Injection Date/Hour'),
		(datatableId, 3, 'gasCd', 'Gas Level'),
		(datatableId, 4, 'referenceValue', 'Reference Value'),
		(datatableId, 5, 'measuredValue', 'Measured Value'),
		(datatableId, 6, 'pctDiff', 'Reference Value % of Span'),
		(datatableId, 7, 'reportedValue', 'Reported Results'),
		(datatableId, 8, 'reportedAPS', 'Reported APS'),
		(datatableId, 9, 'calcReportedValue', 'Recalculated Results'),
		(datatableId, 10, 'calcReportedAPS', 'Recalculated APS');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- Unit-Specific NOx Rate Test
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'UNITDEFSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'testNumber', 'Test Number'),
		(datatableId, 2, 'testReasonCode', 'Reason for Test'),
		(datatableId, 3, 'beginDateTime', 'Test Initiation'),
		(datatableId, 4, 'hidden1', 'HIDDEN'),
		(datatableId, 5, 'hidden2', 'HIDDEN'),
		(datatableId, 6, 'endDateTime', 'Test Completion'),
		(datatableId, 7, 'hidden1', 'HIDDEN'),
		(datatableId, 8, 'hidden2', 'HIDDEN'),
		(datatableId, 9, 'hidden3', 'HIDDEN'),
		(datatableId, 10, 'evalStatus', 'Evaluation Status'),
		(datatableId, 11, 'hidden4', 'HIDDEN'),
		(datatableId, 12, 'submissionStatus', 'Submission Status'),
		(datatableId, 13, 'hidden5', 'HIDDEN'),
		(datatableId, 14, 'hidden6', 'HIDDEN'),
		(datatableId, 15, 'submittedOn', 'Submission Date/Time');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'UNITDEFTEST', 'SELECT * FROM {SCHEMA}.rpt_qa_ae_testing($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'qIName', 'QI Name'),
		(datatableId, 2, 'hidden1', 'HIDDEN'),
		(datatableId, 3, 'aetbName', 'AETB Name'),
		(datatableId, 5, 'examDate', 'Exam Date'),
		(datatableId, 6, 'hidden3', 'HIDDEN'),
		(datatableId, 7, 'aetbPhone', 'AETB Phone Number'),
		(datatableId, 9, 'providerName', 'Provider Name'),
		(datatableId, 10, 'hidden5', 'HIDDEN'),
		(datatableId, 11, 'aetbEmail', 'AETB Email'),
		(datatableId, 13, 'providerEmail', 'Provider Email');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'UNITDEFGAS', 'SELECT * FROM {SCHEMA}.rpt_qa_protocol_gas($1)')
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
	VALUES(datasetCode, tableOrder, 'UNITDEFSTAT', 'SELECT * FROM {SCHEMA}.rpt_qa_unitdef_statistics($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'fuelType', 'Fuel Type'),
		(datatableId, 2, 'defaultReported', 'Default NOx Emission Rate Reported'),
		(datatableId, 3, 'defaultCalculated', 'Default NOx Emission Rate Recalculated'),
		(datatableId, 4, 'opCondition', 'Operating Condition'),
		(datatableId, 5, 'identicalId', 'Identical Unit Group ID'),
		(datatableId, 3, 'noUnitsGroup', 'No. of Units in Group'),
		(datatableId, 4, 'noTestGroup', 'No. of Tests for Group');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
----------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'UNITDEFRUN', 'SELECT * FROM {SCHEMA}.rpt_qa_unitdef_run($1)')
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
		(datatableId, 7, 'runUsed', 'Run Used?');
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- DAHS Verification
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'DAHSSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- Dry Gas Meter Calibration (Sorbent Trap Monitoring System)
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'DGFMCALSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- Leak Check
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'LEAKSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- Mass Flow Meter Calibration (Sorbent Trap Monitoring System)
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'MFMCALSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- Other Test
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'OTHERSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- PEMS Accuracy Check
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'PEMSACCSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- Quarterly Gas Audit (HCl and HF monitoring systems)
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'QGASUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- Temperature sensor calibration (sorbent trap monitoring systems)
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'TSCALSUM', 'SELECT * FROM {SCHEMA}.rpt_qa_test_summary($1)')
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
		(datatableId, 9, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'submissionStatus', 'Submission Status'),
		(datatableId, 116, 'testDescription', 'Test Description');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- RATA
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATASUM', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_summary($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'systemIdentifier', 'System ID'),
		(datatableId, 2, 'systemTypeCode', 'System Type'),
		(datatableId, 3, 'endDateTime', 'Test Completion'),
		(datatableId, 4, 'testNumber', 'Test Number'),
		(datatableId, 5, 'testReasonCode', 'Reason for Test'),
		(datatableId, 6, 'testResultCode', 'Reported Test Results'),
		(datatableId, 7, 'noLoad', '# of Op. Levels'),
		(datatableId, 8, 'gpIndicator', 'Grace Period Test?'),
		(datatableId, 9, 'calcTestResultCode', 'EPA Calculated Result'),
		(datatableId, 10, 'hidden1', 'HIDDEN'),
		(datatableId, 11, 'hidden2', 'HIDDEN'),
		(datatableId, 12, 'hidden3', 'HIDDEN'),
		(datatableId, 13, 'evalStatus', 'Evaluation Status'),
		(datatableId, 14, 'hidden4', 'HIDDEN'),
		(datatableId, 15, 'biasAdjFactor', 'Reported BAF'),
		(datatableId, 16, 'submissionStatus', 'Submission Status'),
		(datatableId, 17, 'hidden5', 'HIDDEN'),
		(datatableId, 18, 'calcBiasAdjFactor', 'EPA Calculated BAF'),
		(datatableId, 19, 'submittedOn', 'Submission Date/Time'),
		(datatableId, 20, 'hidden6', 'HIDDEN'),
		(datatableId, 21, 'freqCd', 'RATA Frequency');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATATEST', 'SELECT * FROM {SCHEMA}.rpt_qa_ae_testing($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'qIName', 'QI Name'),
		(datatableId, 2, 'hidden1', 'HIDDEN'),
		(datatableId, 3, 'aetbName', 'AETB Name'),
		(datatableId, 5, 'examDate', 'Exam Date'),
		(datatableId, 6, 'hidden3', 'HIDDEN'),
		(datatableId, 7, 'aetbPhone', 'AETB Phone Number'),
		(datatableId, 9, 'providerName', 'Provider Name'),
		(datatableId, 10, 'hidden5', 'HIDDEN'),
		(datatableId, 11, 'aetbEmail', 'AETB Email'),
		(datatableId, 13, 'providerEmail', 'Provider Email');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'testId', null);
--------------------------------------------------------------------------------------------------------------------
-- RATA MID
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAMID', 'SELECT * FROM {SCHEMA}.get_rata_statistics($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'rowName1', ''),
		(datatableId, 2, 'reported', 'Reported'),
		(datatableId, 3, 'calculated', 'Recalculated'),
		(datatableId, 5, 'rowName2', ''),
		(datatableId, 6, 'reported2', 'Reported'),
		(datatableId, 7, 'calculated2', 'Recalculated');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'M');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAMIDRUN', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_run($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'run', 'Run'),
		(datatableId, 2, 'startDate', 'Start Date'),
		(datatableId, 3, 'endDate', 'End Date'),
		(datatableId, 4, 'runStatus', 'Run Status'),
		(datatableId, 5, 'monSysValue', 'Monitoring System Value'),
		(datatableId, 6, 'refMethodValue', 'Reference Method Value'),
		(datatableId, 7, 'grossLoadOrVel', 'Gross Load or Velocity');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'M');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAMIDSUPP', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_supp($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'co2Method', 'CO2/O2 Reference Method'),
		(datatableId, 2, 'hidden1', 'HIDDEN'),
		(datatableId, 3, 'stackArea', 'Stack Area'),
		(datatableId, 4, 'stackDiameter', 'Stack Diameter'),
		(datatableId, 5, 'hidden2', 'HIDDEN'),
		(datatableId, 6, 'calcStackArea', 'Recalculated Stack Area'),
		(datatableId, 7, 'noTraverse', 'No. of Traverse Points'),
		(datatableId, 8, 'hidden3', 'HIDDEN'),
		(datatableId, 9, 'calcWaf', 'Calculated (or Rect Duct) WAF'),
		(datatableId, 10, 'defaultWaf', 'Default WAF'),
		(datatableId, 11, 'hidden4', 'HIDDEN'),
		(datatableId, 12, 'calcCalcWaf', 'Recalculated WAF');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'M');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAMIDFLOW', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_flow_run($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'runNum', 'Run Num.'),
		(datatableId, 2, 'noTrav', 'No. Traverse Points for this Run'),
		(datatableId, 3, 'barPressure', 'Barometric Pressure (in Hg)'),
		(datatableId, 4, 'staticPressure', 'Static Pressure (in H2O)'),
		(datatableId, 5, 'pctCO2', '%CO2'),
		(datatableId, 6, 'pctO2', '%O2'),
		(datatableId, 7, 'pctH2O', '%H2O'),
		(datatableId, 8, 'dryRep', 'Dry Molecular Weight Rep.'),
		(datatableId, 9, 'dryCalc', 'Dry Molecular Weight Calc.'),
		(datatableId, 10, 'wetRep', 'Wet Molecular Weight Rep.'),
		(datatableId, 11, 'wetCalc', 'Wet Molecular Weight Calc.'),
		(datatableId, 12, 'unadjRep', 'Unadjusted Run Velocity (ft/sec) Rep.'),
		(datatableId, 13, 'unadjCalc', 'Unadjusted Run Velocity (ft/sec) Calc.'),
		(datatableId, 14, 'avgRep', 'Average Run Velocity Including Wall Effects (ft/sec) Rep.'),
		(datatableId, 15, 'avgRepCalc', 'Average Run Velocity Including Wall Effects (ft/sec) Calc.'),
		(datatableId, 16, 'calcWafRep', 'Calculated WAF Derived from this Test Run Rep.'),
		(datatableId, 17, 'calcWafCal', 'Calculated WAF Derived from this Test Run Calc.'),
		(datatableId, 18, 'avgFlow', 'Average Stack Flow');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'M');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAMIDTRAV', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_traverse($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'runNum', 'Run Num.'),
		(datatableId, 2, 'traverseId', 'Traverse Point ID'),
		(datatableId, 3, 'probeType', 'Probe Type'),
		(datatableId, 4, 'pressureDeviceType', 'Pressure Meas. Device Type'),
		(datatableId, 5, 'probeId', 'Probe ID'),
		(datatableId, 6, 'velocityCoef', 'Velocity Calib. Coeff.'),
		(datatableId, 7, 'lastProbeDate', 'Last Probe Date'),
		(datatableId, 8, 'avgDiff', 'Avg. Diff. Pressure (In H2O)'),
		(datatableId, 9, 'avgSqrDiffPress', 'Avg. of Square Roots of Vel. Differential Pressure'),
		(datatableId, 10, 'stackTemp', 'Stack Temp.'),
		(datatableId, 11, 'yawAngle', 'Yaw Angle'),
		(datatableId, 12, 'pitchAngle', 'Pitch Angle'),
		(datatableId, 13, 'unadjRep', 'Unadjusted Velocity (ft/sec) Rep.'),
		(datatableId, 14, 'unadjCalc', 'Unadjusted Velocity (ft/sec) Calc.'),
		(datatableId, 15, 'pointUsed', 'Point Used Ind.'),
		(datatableId, 16, 'noWallEffect', 'No. of Wall Effects Points'),
		(datatableId, 17, 'repVelocity', 'Rep. Velocity');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'M');
--------------------------------------------------------------------------------------------------------------------
-- RATA HIGH
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAHIGH', 'SELECT * FROM {SCHEMA}.get_rata_statistics($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'rowName1', ''),
		(datatableId, 2, 'reported', 'Reported'),
		(datatableId, 3, 'calculated', 'Recalculated'),
		(datatableId, 5, 'rowName2', ''),
		(datatableId, 6, 'reported2', 'Reported'),
		(datatableId, 7, 'calculated2', 'Recalculated');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'H');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAHIGHRUN', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_run($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'run', 'Run'),
		(datatableId, 2, 'startDate', 'Start Date'),
		(datatableId, 3, 'endDate', 'End Date'),
		(datatableId, 4, 'runStatus', 'Run Status'),
		(datatableId, 5, 'monSysValue', 'Monitoring System Value'),
		(datatableId, 6, 'refMethodValue', 'Reference Method Value'),
		(datatableId, 7, 'grossLoadOrVel', 'Gross Load or Velocity');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'H');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAHIGHSUPP', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_supp($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'co2Method', 'CO2/O2 Reference Method'),
		(datatableId, 2, 'hidden1', 'HIDDEN'),
		(datatableId, 3, 'stackArea', 'Stack Area'),
		(datatableId, 4, 'stackDiameter', 'Stack Diameter'),
		(datatableId, 5, 'hidden2', 'HIDDEN'),
		(datatableId, 6, 'calcStackArea', 'Recalculated Stack Area'),
		(datatableId, 7, 'noTraverse', 'No. of Traverse Points'),
		(datatableId, 8, 'hidden3', 'HIDDEN'),
		(datatableId, 9, 'calcWaf', 'Calculated (or Rect Duct) WAF'),
		(datatableId, 10, 'defaultWaf', 'Default WAF'),
		(datatableId, 11, 'hidden4', 'HIDDEN'),
		(datatableId, 12, 'calcCalcWaf', 'Recalculated WAF');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'H');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAHIGHFLOW', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_flow_run($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'runNum', 'Run Num.'),
		(datatableId, 2, 'noTrav', 'No. Traverse Points for this Run'),
		(datatableId, 3, 'barPressure', 'Barometric Pressure (in Hg)'),
		(datatableId, 4, 'staticPressure', 'Static Pressure (in H2O)'),
		(datatableId, 5, 'pctCO2', '%CO2'),
		(datatableId, 6, 'pctO2', '%O2'),
		(datatableId, 7, 'pctH2O', '%H2O'),
		(datatableId, 8, 'dryRep', 'Dry Molecular Weight Rep.'),
		(datatableId, 9, 'dryCalc', 'Dry Molecular Weight Calc.'),
		(datatableId, 10, 'wetRep', 'Wet Molecular Weight Rep.'),
		(datatableId, 11, 'wetCalc', 'Wet Molecular Weight Calc.'),
		(datatableId, 12, 'unadjRep', 'Unadjusted Run Velocity (ft/sec) Rep.'),
		(datatableId, 13, 'unadjCalc', 'Unadjusted Run Velocity (ft/sec) Calc.'),
		(datatableId, 14, 'avgRep', 'Average Run Velocity Including Wall Effects (ft/sec) Rep.'),
		(datatableId, 15, 'avgRepCalc', 'Average Run Velocity Including Wall Effects (ft/sec) Calc.'),
		(datatableId, 16, 'calcWafRep', 'Calculated WAF Derived from this Test Run Rep.'),
		(datatableId, 17, 'calcWafCal', 'Calculated WAF Derived from this Test Run Calc.'),
		(datatableId, 18, 'avgFlow', 'Average Stack Flow');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'H');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATAHIGHTRAV', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_traverse($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'runNum', 'Run Num.'),
		(datatableId, 2, 'traverseId', 'Traverse Point ID'),
		(datatableId, 3, 'probeType', 'Probe Type'),
		(datatableId, 4, 'pressureDeviceType', 'Pressure Meas. Device Type'),
		(datatableId, 5, 'probeId', 'Probe ID'),
		(datatableId, 6, 'velocityCoef', 'Velocity Calib. Coeff.'),
		(datatableId, 7, 'lastProbeDate', 'Last Probe Date'),
		(datatableId, 8, 'avgDiff', 'Avg. Diff. Pressure (In H2O)'),
		(datatableId, 9, 'avgSqrDiffPress', 'Avg. of Square Roots of Vel. Differential Pressure'),
		(datatableId, 10, 'stackTemp', 'Stack Temp.'),
		(datatableId, 11, 'yawAngle', 'Yaw Angle'),
		(datatableId, 12, 'pitchAngle', 'Pitch Angle'),
		(datatableId, 13, 'unadjRep', 'Unadjusted Velocity (ft/sec) Rep.'),
		(datatableId, 14, 'unadjCalc', 'Unadjusted Velocity (ft/sec) Calc.'),
		(datatableId, 15, 'pointUsed', 'Point Used Ind.'),
		(datatableId, 16, 'noWallEffect', 'No. of Wall Effects Points'),
		(datatableId, 17, 'repVelocity', 'Rep. Velocity');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'H');
--------------------------------------------------------------------------------------------------------------------
-- RATA LOW
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATALOW', 'SELECT * FROM {SCHEMA}.get_rata_statistics($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'rowName1', ''),
		(datatableId, 2, 'reported', 'Reported'),
		(datatableId, 3, 'calculated', 'Recalculated'),
		(datatableId, 5, 'rowName2', ''),
		(datatableId, 6, 'reported2', 'Reported'),
		(datatableId, 7, 'calculated2', 'Recalculated');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'L');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATALOWRUN', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_run($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'run', 'Run'),
		(datatableId, 2, 'startDate', 'Start Date'),
		(datatableId, 3, 'endDate', 'End Date'),
		(datatableId, 4, 'runStatus', 'Run Status'),
		(datatableId, 5, 'monSysValue', 'Monitoring System Value'),
		(datatableId, 6, 'refMethodValue', 'Reference Method Value'),
		(datatableId, 7, 'grossLoadOrVel', 'Gross Load or Velocity');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'L');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATALOWSUPP', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_supp($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'co2Method', 'CO2/O2 Reference Method'),
		(datatableId, 2, 'hidden1', 'HIDDEN'),
		(datatableId, 3, 'stackArea', 'Stack Area'),
		(datatableId, 4, 'stackDiameter', 'Stack Diameter'),
		(datatableId, 5, 'hidden2', 'HIDDEN'),
		(datatableId, 6, 'calcStackArea', 'Recalculated Stack Area'),
		(datatableId, 7, 'noTraverse', 'No. of Traverse Points'),
		(datatableId, 8, 'hidden3', 'HIDDEN'),
		(datatableId, 9, 'calcWaf', 'Calculated (or Rect Duct) WAF'),
		(datatableId, 10, 'defaultWaf', 'Default WAF'),
		(datatableId, 11, 'hidden4', 'HIDDEN'),
		(datatableId, 12, 'calcCalcWaf', 'Recalculated WAF');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'L');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATALOWFLOW', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_flow_run($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'runNum', 'Run Num.'),
		(datatableId, 2, 'noTrav', 'No. Traverse Points for this Run'),
		(datatableId, 3, 'barPressure', 'Barometric Pressure (in Hg)'),
		(datatableId, 4, 'staticPressure', 'Static Pressure (in H2O)'),
		(datatableId, 5, 'pctCO2', '%CO2'),
		(datatableId, 6, 'pctO2', '%O2'),
		(datatableId, 7, 'pctH2O', '%H2O'),
		(datatableId, 8, 'dryRep', 'Dry Molecular Weight Rep.'),
		(datatableId, 9, 'dryCalc', 'Dry Molecular Weight Calc.'),
		(datatableId, 10, 'wetRep', 'Wet Molecular Weight Rep.'),
		(datatableId, 11, 'wetCalc', 'Wet Molecular Weight Calc.'),
		(datatableId, 12, 'unadjRep', 'Unadjusted Run Velocity (ft/sec) Rep.'),
		(datatableId, 13, 'unadjCalc', 'Unadjusted Run Velocity (ft/sec) Calc.'),
		(datatableId, 14, 'avgRep', 'Average Run Velocity Including Wall Effects (ft/sec) Rep.'),
		(datatableId, 15, 'avgRepCalc', 'Average Run Velocity Including Wall Effects (ft/sec) Calc.'),
		(datatableId, 16, 'calcWafRep', 'Calculated WAF Derived from this Test Run Rep.'),
		(datatableId, 17, 'calcWafCal', 'Calculated WAF Derived from this Test Run Calc.'),
		(datatableId, 18, 'avgFlow', 'Average Stack Flow');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'L');
--------------------------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'RATALOWTRAV', 'SELECT * FROM {SCHEMA}.rpt_qa_rata_traverse($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES

		(datatableId, 1, 'runNum', 'Run Num.'),
		(datatableId, 2, 'traverseId', 'Traverse Point ID'),
		(datatableId, 3, 'probeType', 'Probe Type'),
		(datatableId, 4, 'pressureDeviceType', 'Pressure Meas. Device Type'),
		(datatableId, 5, 'probeId', 'Probe ID'),
		(datatableId, 6, 'velocityCoef', 'Velocity Calib. Coeff.'),
		(datatableId, 7, 'lastProbeDate', 'Last Probe Date'),
		(datatableId, 8, 'avgDiff', 'Avg. Diff. Pressure (In H2O)'),
		(datatableId, 9, 'avgSqrDiffPress', 'Avg. of Square Roots of Vel. Differential Pressure'),
		(datatableId, 10, 'stackTemp', 'Stack Temp.'),
		(datatableId, 11, 'yawAngle', 'Yaw Angle'),
		(datatableId, 12, 'pitchAngle', 'Pitch Angle'),
		(datatableId, 13, 'unadjRep', 'Unadjusted Velocity (ft/sec) Rep.'),
		(datatableId, 14, 'unadjCalc', 'Unadjusted Velocity (ft/sec) Calc.'),
		(datatableId, 15, 'pointUsed', 'Point Used Ind.'),
		(datatableId, 16, 'noWallEffect', 'No. of Wall Effects Points'),
		(datatableId, 17, 'repVelocity', 'Rep. Velocity');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES 
		(datatableId, 1, 'testId', null),
		(datatableId, 2, 'opLevelCd', 'L');

END $$;
