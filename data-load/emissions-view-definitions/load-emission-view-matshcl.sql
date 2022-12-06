DO $$
DECLARE
	datasetCode text = 'MATSHCL';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'MATS HCL View', 16, 'MATS HCL data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'MATS HCL', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 2, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 3, 'mats_load', 'matsLoad', 'MATS Load'),
		(datatableId, 4, 'mats_startup_shutdown', 'matsStartupShutdown', 'MATS Startup - Shutdown'),
		(datatableId, 5, 'hcl_conc_value', 'hclConcValue', 'HCl Conc. Value'),
		(datatableId, 6, 'hcl_conc_modc_cd', 'hclConcMODCCode', 'HCl Conc. MODC'),
		(datatableId, 7, 'hcl_conc_pma', 'hclConcPMA', 'HCl Conc. PMA'),
		(datatableId, 8, 'flow_rate', 'flowRate', 'Flow Rate'),
		(datatableId, 9, 'flow_modc', 'flowMODC', 'Flow MODC'),
		(datatableId, 10, 'flow_pma', 'flowPMA', 'Flow PMA'),
		(datatableId, 11, 'rpt_pct_diluent', 'rptPCTDiluent', 'Rptd. % Diluent'),
		(datatableId, 12, 'diluent_parameter', 'diluentParameter', 'Diluent Parameter'),
		(datatableId, 13, 'calc_pct_diluent', 'calcPCTDiluent', '% Diluent Used in Calc.'),
		(datatableId, 14, 'diluent_modc', 'diluentMODC', 'Diluent MODC'),
		(datatableId, 15, 'calc_pct_h2o', 'calcPCTH2O', '% H2O used in Calc.'),
		(datatableId, 16, 'h2o_source', 'h2oSource', 'Source of H2O Value'),
		(datatableId, 17, 'f_factor', 'fFactor', 'F-Factor'),
		(datatableId, 18, 'hcl_formula_cd', 'hclFormulaCode', 'HCl Formula Code'),
		(datatableId, 19, 'rpt_hcl_rate', 'rptHCLRate', 'Rpt. HCl Rate'),
		(datatableId, 20, 'calc_hcl_rate', 'calcHCLRate', 'Calc. HCl Rate'),
		(datatableId, 21, 'hcl_uom', 'hclUOM', 'HCl UOM'),
		(datatableId, 22, 'hcl_modc_cd', 'hclMODCCode', 'HCL MODC'),
		(datatableId, 23, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;