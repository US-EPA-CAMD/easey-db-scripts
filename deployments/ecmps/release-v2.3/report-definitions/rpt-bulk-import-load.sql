DO $$
DECLARE
	datasetCode text := 'BULK_IMPORT';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	DELETE FROM camdaux.template_code WHERE group_cd = datasetCode;

	INSERT INTO camdaux.template_code(template_cd, group_cd, template_type, display_name)
	VALUES
		('BLKIMPFILE', datasetCode, '1COLTBL', 'Import File'),
		('BLKIMPERR', datasetCode, 'DEFAULT', 'Errors');

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, no_results_msg)
	VALUES(datasetCode, groupCode, 'Bulk Import Results Report', 'Import completed with no errors.');
------------------------------------------------------------------------------------------------
	-- Facility information
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
		(datatableId, 5, 'countyName', 'County');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'facilityId', null);
------------------------------------------------------------------------------------------------
	-- Import file details
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'BLKIMPFILE', 'SELECT * FROM camdecmpswks.rpt_bulk_import_file($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'fileName', 'File Name'),
		(datatableId, 2, 'fileType', 'Type'),
		(datatableId, 3, 'unitStackPipe', 'Unit/Stack/Pipe'),
		(datatableId, 4, 'reportingPeriod', 'Reporting Period'),
		(datatableId, 5, 'status', 'Status');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'importId', null);
------------------------------------------------------------------------------------------------
	-- Errors (one row per message)
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'BLKIMPERR', 'SELECT * FROM camdecmpswks.rpt_bulk_import_errors($1)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'errorMessage', 'Error');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'importId', null);
END $$;
