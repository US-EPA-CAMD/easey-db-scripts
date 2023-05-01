DO $$
DECLARE
	datasetCode text := 'COUNTS';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Emissions View Counts', 0, null);

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Emissions View Counts', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'mon_plan_id', 'monPlanId', 'Monitor Plan Id'),
		(datatableId, 2, 'mon_loc_id', 'locationId', 'Location Id'),
		(datatableId, 3, 'unit_stack', 'unitStack', 'Unit/Stack'),
		(datatableId, 4, 'dataset_cd', 'dataSetCode', 'View Code'),
		(datatableId, 5, 'rpt_period_id', 'rptPeriodId', 'Reporting Period Id'),
		(datatableId, 6, 'rpt_period_year', 'rptPeriodYear', 'Reporting Period Year'),
		(datatableId, 7, 'rpt_period_qtr', 'rptPeriodQuarter', 'Reporting Period Quarter'),
		(datatableId, 8, 'count', 'count', 'Count');
END $$;