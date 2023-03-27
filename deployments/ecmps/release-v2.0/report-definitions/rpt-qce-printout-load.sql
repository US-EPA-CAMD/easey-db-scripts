DO $$
DECLARE
	datasetCode text := 'QCE';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'QA/Cert Events Printout Report');
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
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'QCE', 'SELECT * FROM {SCHEMA}.rpt_qa_cert_event($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'eventCode', 'Event Code'),
		(datatableId, 3, 'eventDateHour', 'Event Date/Hr'),
		(datatableId, 4, 'systemIdentifier', 'System ID'),
		(datatableId, 5, 'systemTypeCode', 'System Type'),
		(datatableId, 6, 'componentIdentifier', 'Component ID'),
		(datatableId, 7, 'componentTypeCode', 'Component Type'),
		(datatableId, 8, 'requiredTestCode', 'Required Test Code'),
		(datatableId, 9, 'conditionalBeginDateHour', 'Conditional Begin Date/Hr'),
		(datatableId, 10, 'lastTestCompletedDateHour', 'Last Test Completed Date/Hr'),
		(datatableId, 11, 'submissionStatus', 'Submitted?');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'qceId', null);
END $$;
