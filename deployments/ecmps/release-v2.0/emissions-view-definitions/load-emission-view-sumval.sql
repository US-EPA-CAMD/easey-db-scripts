DO $$
DECLARE
	datasetCode text := 'SUMVAL';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Quarterly Summary View', 1, 'Quarterly Summary data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Quarterly Summary Values', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'period_description', 'periodDescription', 'Reporting Period'),
		(datatableId, 2, 'row_name', 'rowName', 'Value'),
		(datatableId, 3, 'op_hours', 'opHours', '# of Op. Hours'),
		(datatableId, 4, 'op_time', 'opTime', 'Op. Time (hrs)'),
		(datatableId, 5, 'heat_input', 'heatInput', 'Heat Input (mmBtu)'),
		(datatableId, 6, 'so2_mass', 'so2Mass', 'SO2 Mass (tons)'),
		(datatableId, 7, 'co2_mass', 'co2Mass', 'CO2 Mass (tons)'),
		(datatableId, 8, 'nox_rate', 'noxRate', 'NOx Rate (lb/mmBtu)');
END $$;