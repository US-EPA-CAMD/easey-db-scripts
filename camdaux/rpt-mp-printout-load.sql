DO $$
DECLARE
	datasetCode text := 'MPP';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'Summary Report', 'Monitoring Plan Printout Report', 'There is no data for the specified monitor plan.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Reporting Frequency', 'SELECT * FROM camdecmpswks.rpt_mp_reporting_frequency($1)', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'frequency', 'Frequency'),
		(datatableId, 3, 'beginQuarter', 'Begin Quarter'),
		(datatableId, 4, 'endQuarter', 'End Quarter');
	
	/***** PARAMETERS *****/
	INSERT INTO camdaux.datatable_parameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);

------------------------------------------------------------------------------------------------
	/***** DATATABLE 2 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 2, 'Location Attributes', 'SELECT * FROM camdecmpswks.rpt_mp_location_attribute($1)', null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitStack', 'Unit/Stack'),
		(datatableId, 2, 'ductIndicator', 'Duct Indicator'),
		(datatableId, 3, 'groundElevation', 'Ground Elevation'),
		(datatableId, 4, 'stackHeight', 'Stack Height'),
		(datatableId, 5, 'crossAreaExit', 'Cross Area Exit'),
		(datatableId, 6, 'crossAreaFlow', 'Cross Area Flow'),
		(datatableId, 7, 'materialCode', 'Material Code'),
		(datatableId, 8, 'shapeCode', 'Shape Code'),
		(datatableId, 9, 'beginDate', 'Begin Date'),
		(datatableId, 10, 'endDate', 'End Date');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.datatable_parameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);

------------------------------------------------------------------------------------------------
	/***** DATATABLE 3 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 3, 'Unit Operation/Capacity', 'SELECT * FROM camdecmpswks.rpt_mp_unit_capacity($1)', null)
	RETURNING datatable_id INTO datatableId;
	
	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'unitIdentifier', 'Unit Identifier'),
		(datatableId, 2, 'nonLoadBasedIndicator', 'Non-Load Based Ind'),
		(datatableId, 3, 'commercialOpDate', 'Commence Commercial Operation Date'),
		(datatableId, 4, 'commenceOpDate', 'Commence Operation Date'),
		(datatableId, 5, 'unitTypeCode', 'Unit Type'),
		(datatableId, 6, 'beginDate', 'Begin Date'),
		(datatableId, 7, 'endDate', 'End Date'),
		(datatableId, 8, 'maxHICapacity', 'Max Heat Input Capacity'),
		(datatableId, 9, 'capacityBeginDate', 'Capacity Begin Date'),
		(datatableId, 10, 'capacityEndDate', 'Capacity End Date');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.datatable_parameter(datatable_id, parameter_order, name, default_value)
	VALUES (datatableId, 1, 'monitorPlanId', null);
END $$;