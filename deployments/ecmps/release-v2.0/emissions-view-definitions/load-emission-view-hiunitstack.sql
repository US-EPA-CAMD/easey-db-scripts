DO $$
DECLARE
	datasetCode text = 'HIUNITSTACK';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'Heat Input for Unit/Stack View', 7, 'Heat Input for Unit/Stack data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Heat Input for Unit/Stack', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 4, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 5, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 6, 'load_range', 'loadRange', 'Load Range'),
		(datatableId, 7, 'common_stack_load_range', 'commonStackLoadRange', 'Common Stack Load Range'),
		(datatableId, 8, 'hi_formula_cd', 'hiFormulaCode', 'HI Formula Code'),
		(datatableId, 9, 'rpt_hi_rate', 'rptHIRate', 'Rpt. HI Rate  (mmBtu/hr)'),
		(datatableId, 10, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 11, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;