DO $$
DECLARE
	datasetCode text := 'TEE';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Test Extensions and Exemptions Printout Report');
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
	VALUES(datasetCode, tableOrder, 'TEE', 'SELECT * FROM {SCHEMA}.rpt_qa_tee($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'extensionExemptionType', 'Type'),
		(datatableId, 3, 'rptPeriodAbr', 'Reporting Period'),
		(datatableId, 4, 'systemIdentifier', 'System ID'),
		(datatableId, 5, 'systemTypeCode', 'System Type'),
		(datatableId, 6, 'componentIdentifier', 'Component ID'),
		(datatableId, 7, 'componentTypeCode', 'Component Type'),
		(datatableId, 8, 'spanScaleCd', 'Span Scale Code'),
		(datatableId, 9, 'fuelCd', 'Fuel Code'),
		(datatableId, 10, 'hoursUsed', 'Hours Used'),
		(datatableId, 11, 'submissionStatus', 'Submitted?');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'teeId', null);
END $$;