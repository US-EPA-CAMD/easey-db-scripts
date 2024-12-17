DO $$
DECLARE
	datasetCode text := 'EMSR';
	groupCode text := 'REPORT';
	tableOrder integer := 0;
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name)
	VALUES(datasetCode, groupCode, 'Emissions Summary Report');	
------------------------------------------------------------------------------------------------
tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FACINFO2C', 'SELECT * FROM {SCHEMA}.rpt_facility_information($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'facilityName', 'Facility Name'),
		(datatableId, 2, 'orisCode', 'Facility ID (ORISPL)'),
		(datatableId, 3, 'locationInfo', 'Monitoring Plan Locations'),
		(datatableId, 4, 'stateCode', 'State'),
		(datatableId, 5, 'countyName', 'County');
	
	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'facilityId', null),
		(datatableId, 2, 'monitorPlanId', null);

-----------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'QRTSUMDATA', 'SELECT * FROM {SCHEMA}.rpt_quartely_em_summary_data($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'calendar_year', 'Year'),
		(datatableId, 3, 'period', 'Period'),
		(datatableId, 4, 'op_hours', 'No. of Op. Hours'),
		(datatableId, 5, 'op_days', 'No. of Op. Days'),
		(datatableId, 6, 'op_time', 'Op. Time'),
		(datatableId, 7, 'hit', 'Heat Input (mmBtu)'),
		(datatableId, 8, 'so2m', 'SO2 Mass (tons)'),
		(datatableId, 9, 'co2m', 'CO2 Mass (tons)'),
		(datatableId, 10, 'noxr', 'NOx Rate (lb/mmBtu)'),
		(datatableId, 11, 'noxm', 'NOx Mass (tons)'),
		(datatableId, 12, 'bco2', 'BCO2 Mass (tons)');


	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null);
------------------------------------------------------------------------------------------------
	tableOrder := tableOrder + 1;
	INSERT INTO camdaux.datatable(dataset_cd, table_order, template_cd, sql_statement)
	VALUES(datasetCode, tableOrder, 'FUELOPHRS', 'SELECT * FROM {SCHEMA}.rpt_em_fuel_operating_hours($1, $2)')
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, display_name)
	VALUES
		(datatableId, 1, 'location', 'Location'),
		(datatableId, 2, 'calendar_year', 'Year'),
		(datatableId, 3, 'period', 'Period'),
		(datatableId, 4, 'fuel_cd', 'Fuel Code'),
		(datatableId, 5, 'op_hours', 'No. of Op. Hours');

	/***** PARAMETERS *****/
	INSERT INTO camdaux.dataparameter(datatable_id, parameter_order, name, default_value)
	VALUES
		(datatableId, 1, 'monitorPlanId', null),
		(datatableId, 2, 'year', null);
------------------------------------------------------------------------------------------------
END $$;
