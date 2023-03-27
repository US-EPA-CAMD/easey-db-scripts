DO $$
DECLARE
	datasetCode text := 'MOISTURE';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Moisture View', 21, 'Moisture data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Moisture', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 4, 'h2o_modc', 'h2oMODC', 'H2O MODC'),
		(datatableId, 5, 'h2o_pma', 'h2oPMA', 'H2O PMA'),
		(datatableId, 6, 'pct_o2_wet', 'pctO2Wet', '% O2 Wet'),
		(datatableId, 7, 'o2_wet_modc', 'o2WetMODC', 'O2 Wet MODC'),
		(datatableId, 8, 'pct_o2_dry', 'pctO2Dry', '% O2 Dry'),
		(datatableId, 9, 'o2_dry_modc', 'o2DryMODC', 'O2 Dry MODC'),
		(datatableId, 10, 'h2o_formula_cd', 'h2oFormulaCode', 'H2O Formula Code'),
		(datatableId, 11, 'rpt_pct_h2o', 'rptPCTH2O', 'Reported % H2O'),
		(datatableId, 12, 'calc_pct_h2o', 'calcPCTH2O', 'Calculated % H2O'),
		(datatableId, 13, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;