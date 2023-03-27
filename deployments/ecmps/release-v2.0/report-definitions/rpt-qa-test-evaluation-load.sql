DO $$
DECLARE
	datasetCode text := 'TEST_EVAL';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
	VALUES(datasetCode, groupCode, 'QA/Certification Tests Evaluation Report', 'Evaluation completed with no errors or informational messages.');
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
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'EVAL', 'SELECT * FROM camdecmpswks.rpt_qa_test_evaluation_results($1)')
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
		(datatableId, 8, 'categoryDescription', 'Category'),
		(datatableId, 9, 'checkCode', 'Check Code'),
		(datatableId, 10, 'resultMessage', 'Result Message');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'testId', null);
END $$;
