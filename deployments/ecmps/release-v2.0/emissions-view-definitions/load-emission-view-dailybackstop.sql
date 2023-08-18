DO $$
DECLARE
	datasetCode text := 'DAILYBACKSTOP';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Daily Backstop View', 23, 'Daily Backstop data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Daily Backstop View', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'unit_name', 'unitName', 'Unit'),
		(datatableId, 2, 'op_date', 'opDate', 'Op. Date'),
		(datatableId, 3, 'daily_noxm', 'dailyNOXMass', 'Daily NOx Mass Rate (lb/hr)'),
		(datatableId, 4, 'daily_hit', 'daily_hit', 'Daily Heat Input'),
		(datatableId, 5, 'daily_avg_noxr', 'dailyAvgNOXRate', 'Daily Avg. NOx Rate (lb/mmBtu)'),
		(datatableId, 6, 'daily_noxm_exceed', 'dailyNOXMassExceedence', 'Daily NOx Mass Exceedence'),
		(datatableId, 7, 'cumulative_os_noxm_exceed', 'cumulativeNOXMassExceedence', 'Cumulative NOx Mass Exceedence');
END $$;